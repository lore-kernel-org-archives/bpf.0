Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFA63A0E85;
	Thu,  9 Apr 2026 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775730326; cv=none; b=HEaqtmRQyStxpdxStoH2BRvbgIubfql81Y5qpk06f3Jnp5oDtfEp4Qdj/MpLQYbYYxar8OL0d5yInE9aVrS5LFhnlclOlQqaYl5fBoVfwVx30NKMzcDRedoEZ/qGo/KUrrj68yRgxK+AekBJwspo+hwquG/HXI5pM2mCxX1oub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775730326; c=relaxed/simple;
	bh=XATXoait2T8j0kzyLu+C/P7uYA2aRdMiSGk3sOeuC74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQt9jXmIz4vb9HN88LRAACWy+/T9E+36DVJSCYO2k3vEgfae362uAuA+TkO8YFi5pqR5vOcz0GI+TBRbBfBA3hJsfsX2zczPysjfAJfGLGzjBETFi2dVfuKrMRVJoBc7kFCAZKBqU+JDIsVp8E2LzhdNDt4tVqJn4pz7YlkAmfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=n5ernpnW; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="n5ernpnW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yF
	M9wTyIvnHpysEQ2eBANRF9u4U8Q1IOhZlhqX9qWGM=; b=n5ernpnWQFgwp8gvJe
	zxCEGqBX+4pjDV2tEVcGYzIBchsn4mB5VEUNIIeFCK8ZilfMnKChD/pv4FOUa6HG
	K2l93sUB1B3t1XFkfxB9JAK29cff28c6h8EdEIzoaV3M5YYa8kraAwFnCH5r06Xi
	F48XCDizkYqPkoSpySxL6Q8/I=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAXGJ5SftdpOqlvAQ--.135S2;
	Thu, 09 Apr 2026 18:24:24 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: olsajiri@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mattbobrowski@google.com,
	memxor@gmail.com,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf] bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret on security_task_alloc
Date: Thu,  9 Apr 2026 18:24:18 +0800
Message-Id: <20260409102418.258397-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <adZBzjB8bcX344LY@krava>
References: <adZBzjB8bcX344LY@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAXGJ5SftdpOqlvAQ--.135S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4rGF4ftFWDtr13Xr4rGrg_yoWfuFb_uF
	WkJFy7Gw45W3srCF1DCw47ZrW2gry5WFZxZ34jqF1a93sxt3yjqr1DKrsYgF17Gw4UtFW3
	Crn5KrWSvw1IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VU1Prc3UUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0BkGfmnXfln3vwAA3g

On Wed, 8 Apr 2026 13:53:50 +0200 Jiri Olsa wrote:

[...]

> > +void bpf_security_get_retval_range(const struct bpf_prog *prog,
> > +				   struct bpf_retval_range *retval_range)
> > +{
> > +	if (btf_id_set_contains(&bool_security_hooks, prog->aux->attach_btf_id)) {
> > +		retval_range->minval = 0;
> > +		retval_range->maxval = 1;
> > +	} else {
> > +		retval_range->minval = -MAX_ERRNO;
> > +		retval_range->maxval = 0;
> > +	}
> > +}
> 
> ai has a point that fmod_ret can attach to other than security functions 
> 
> https://sashiko.dev/#/patchset/20260408094816.228322-1-yangfeng59949%40163.com
> 
> most of them seem to return errno (ERRNO), but there's also few with
> 'TRUE' and one with 'NULL' ..  we could check if the function is on
> the injection list and check the return value accordingly?
> 
> jirka

Oh right, I missed that. I'm also setting the correct return values for the error injection cases and will submit after testing.

