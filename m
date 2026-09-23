Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468E039D3EB;
	Wed, 23 Sep 2026 03:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790135426; cv=none; b=rWLd1+aqW+v1wGkOfFYtYK1abfvGWEgq7Iiwp44ob6Dvq7lK5reWk8I0F1Wxu5c6neJqT2BlAbcpC2DThuLlJ9VUwMajTSwHHjCPnjkQlAiJDoylMm6Nji7P+A0JQSEDrYB1xd7rQnxnJ4pzSRPV9EvFxTxOp+mdHObF3nffNQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790135426; c=relaxed/simple;
	bh=7Os71PnvE6ntMA3sdpcRs2K7Lyp+8otRIYux3AH/JTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqWpVWCcH+95KWUhKGUn3ecTp3AQBrrDNKBj7kCGpIvnVlOh/LDht3eWZfrBfp3Vc0PEgumHqFuhgpgkUh9TaZ/Kgj+yWqXL7VO4GCTqJ7LfIoTyVyC5ovizU+7PHMHYW0hklKjo8sI6YFjh6LO38zJ9EvwDZOGumOHkgJWnMns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=heGrUbRV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="heGrUbRV"
Received: from mac.lan (unknown [52.172.102.187])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1827A20B7167;
	Tue, 22 Sep 2026 20:49:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1827A20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790135376;
	bh=4qNBW+dGbiSli3ozyzoTPucfeNowqfuBoonQfCgC2Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=heGrUbRVHlBJPGBk2EoEBudu+qu+EnSx1d/qx0XR/K6i+aVoN3bWmB8n96Log5Hwf
	 lwfbCsvOsBWT/u55n/wNSh7ZnwV7zHN9K8wbU8+NMQPz3irX2pLqVLQDBCrCMZczL3
	 IR/gQhy5aXNNIg2eKanpSH/sU6lbJ9G0ciSMGnA8=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: alexei.starovoitov@gmail.com
Cc: AutonomousCodeSecurity@microsoft.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	cenzhang@linux.microsoft.com,
	daniel@iogearbox.net,
	davem@davemloft.net,
	dlebrun@google.com,
	eddyz87@gmail.com,
	edumazet@google.com,
	emil@etsalapatis.com,
	horms@kernel.org,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	m.xhonneux@gmail.com,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	song@kernel.org,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf v3] bpf: Fix non-linear SRH access in bpf_update_srh_state()
Date: Tue, 22 Sep 2026 23:49:59 -0400
Message-ID: <20260923035000.78489-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAADnVQJceTGftun8NfbyQdWe1FqLDsd6Ut5mrQFxuVkAvrAAEg@mail.gmail.com>
References: <CAADnVQJceTGftun8NfbyQdWe1FqLDsd6Ut5mrQFxuVkAvrAAEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Sep 13, 2026 at 9:56 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> > +       srh = seg6_get_srh(skb, 0);
> > +       bpf_compute_data_pointers(skb);
> > +       srh_state->srh = srh;
> > +       if (!srh)
> > +               return;
> > +
> > +       srh_state->hdrlen = srh->hdrlen << 3;
> > +       srh_state->valid = true;
>
> This is not equivalent.

Thank you for pointing this out. seg6_get_srh() additionally
validates the header. I will revert to ipv6_find_hdr() in v4.

Thanks,
Cen

