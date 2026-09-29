Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC63F44D3
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712758; cv=none; b=Ox945A7sqpT646MykCEfMW8+/591babXZpy6ZzaGZkPa0JKaS+UUPrK9aWnSdCwPcKFDU3F3iaEXB3ceGyQZUeqsRo7KulCH/vdoAt6acQW2vR82eSmci+e3ji6VfIijjyoCIVlk2V6Q/V4tpW/4qWspcLVedU6H5kXomeA/IVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712758; c=relaxed/simple;
	bh=ElvmyAIAdUzGALgeKxNZcnbLCAo6GuLU08su0r0GSjQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SgGQwT4o0Z5+MFq6hBQxtuSMRLLZLXPbQ5r73ej5gY1qqKPvR66tJAjZ9XnKANUvkNQct5a+v9TBwGebFu6c0G2SYyAJrAvGpFWz/WoKN7c4SPdd5DP5DbJNPfvhpuMYDAHz3xEtTVilsztAD/o3FWOs4PKe8E3pslq0E3ZO1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8Szk4Jg; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8Szk4Jg"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-1480aba0484so590873c88.0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790712756; x=1791317556; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bG7TIp0AeBQEWMmQMoBS6xGlltLOOIWiijr5gb8wRh8=;
        b=K8Szk4Jg0JJdySa4UMmknVSg6cMgwVwWa56Enlfthvdqm3oYYlVzsRX+VFfNJqEVl0
         9ivPmoXA/1T6GGd1rc0vylVDBcTSvHEfv8q23vXPMi7w37uQUILqGSUwCJWaCdfBW8/X
         F6fM34LNRhGXGhiFy5kEo9o3C/ziq9VIQviZGMkY1rnLKFE3w7cVeup14WkqQsOeVYP8
         d3WwNIVV2fGAJU96ns+0K52FkYx3L3GB9o0hd/AdkTOiWDd70Qwh0v36YPnK3O2bCKPi
         5T1WJU0RObzWJ7NxBFLJ9lS5WpEqw9diZ7MHVvaqYy+6X8Ib0Ed2wh6lgmYBTapQvRZ+
         jvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790712756; x=1791317556;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bG7TIp0AeBQEWMmQMoBS6xGlltLOOIWiijr5gb8wRh8=;
        b=Yc93TKrAqEZqApXbsiJvhzXCNJDP/nZ6VYifEm+pD/y7rKEcMuz0GMHKiRp3Bw0sSg
         AtPUxXz6/zn6A5FZwqIEtnv4eiJjo9S8abRO7IfsscuXLAO0jP+Ffk1qRAVnuGJ9vqM0
         qIFSXJV/ul4ZcTTK3sW4zF6zpXZ3OD2S/DDFmb/PCXZhM1H4kER2Xuk/M5vKL7VbPG2Y
         0XnUEBz7dvf0Uv0zbmINXqe6WYM1OLuRSSdQGXDLUWEQfS6JymPViDVNwmDGIigstD8q
         1WrWYbaNhs++7UzIzpRJMnRJncn0dWxyDR3u6uf3/W4h4YSbDNPddQXZSUpJZ9g+rq3j
         d3UQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCuIplP6n14/4EzWyBXeLyuC2KGbQMhCkmItIAcrLfRBxUzhWxv/QV+BOdMwQWo3YE9aU=@vger.kernel.org
X-Gm-Message-State: AFuF++n8amsoZNKTOViCmZYe8fMTxroegCS24Q+cMCHiaBvn6C7stDqo
	Y8iZOJNsK36ilr4bR6kEWHGtuMmjYYT71CEJQebl4FxYgaNdgDj5yKtf
X-Gm-Gg: AYBFou1+roi5z8kPEkQuMN95dfW4nDILeNuuUxQ6EOhX8N1d1EzYviZdmZNKFraG/mX
	8i1S0EqXEMnHCcY74JgmyILu3yrlunHwACpCj1+HJuABgt4W9mevhoryIrkMIVDRickfmZPa20Y
	/DbgbuoBgmHy/K5m/j3Je6UnQODl37aAFoVtZp0yseMjTUapUcvc4o1TaLV6TYSImf239LxwFPx
	p7XU/WKK9ESYQcfk74G8VMQWDLnYrJvbMrHfLY9cz1GSIp4mnzAcml2IzzlamGXnH2s7caxM2x7
	71c2uWeGPg2Q2umtfyqxcBObiUamc27oa/A7/QbETcqUpiLlnoReqBahvVeUBUC55HZwBXR2h0s
	QVx9xY2/kN54SU44leVSD01lRcwRd8ZkLqbPk3cMBNyc2FNeAgDO6cEjxRcAXhTj6SHChfHHQrg
	JFtqPAcxH8gzosrbCJk3jntuveRU0qE0tsxFYgPf+TUyQX5gy5Aqz92km7+fut1GYGutXz38bB7
	CLEOHzza+EGwMcdJYv03D0aKa95q7hp8X5KS6WM07mYEkvRci6V9kP7
X-Received: by 2002:a05:701b:4505:10b0:14c:a265:2f0b with SMTP id a92af1059eb24-14ca2652facmr247125c88.2.1790712755475;
        Tue, 29 Sep 2026 13:12:35 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:abbd:bfa5:f574:cca3? ([2620:10d:c090:500::7:dfd3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14c63acab86sm1301895c88.9.2026.09.29.13.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 13:12:35 -0700 (PDT)
Message-ID: <598051e14850fd088e33fb365868216a607357ae.camel@gmail.com>
Subject: Re: [PATCH bpf-next 02/36] bpf: summarize may write stack slots in
 insn_aux_data
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com
Date: Tue, 29 Sep 2026 13:12:33 -0700
In-Reply-To: <DLPD9Q4H9C62.2QMD510XIOOJR@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
	 <20260926-scev-minimal-rebase-v1-2-c8e5ab5ba79f@gmail.com>
	 <DLPD9Q4H9C62.2QMD510XIOOJR@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-26 at 15:51 +0000, Alexei Starovoitov wrote:
> On Sat, Sep 26, 2026 at 07:20 AM Eduard Zingerman <eddyz87@gmail.com> wro=
te:
> > @@ -662,6 +662,11 @@ struct bpf_insn_aux_data {
> >  	};
> >  	struct btf_struct_meta *kptr_struct_meta;
> >  	u64 map_key_state; /* constant (32 bit) key tracking for maps */
> > +	/*
> > +	 * Per-instruction summary of stack slots in the current frame
> > +	 * that this instruction may write to.
> > +	 */
> > +	DECLARE_BITMAP(may_write_mask, MAX_BPF_STACK_SLOTS);
>=20
> That's 32 bytes per insn and the next patch adds 32 more,
> for every prog whether it has loops or not.
> FM_MAY_WRITE in patch 1 makes every frame_masks a third bigger too.
> commit 481ceda77aeb sized the liveness masks by the stack the frame
> uses to avoid exactly that.
>=20
> bpf_may_write_mask() is the only accessor.
> Can the summary stay in liveness.c, as wide as the subprog's stack,
> and only for insns with scc !=3D 0 ?

I did some profiling and may_write_mask does not show as a big hog in
total memory consumption increase. (+50% is the biggest observed
increase). The biggest increase is from a loop_stack_entry array in
bpf_func_state, and from a fact that I pushed bpf_func_state to a 2KB
allocation bucket. I'll see what can be done there.
