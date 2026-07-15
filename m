Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA6C443E36
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139080; cv=none; b=LKjgd95W4s5RrQd2MgaePiBI3bXjW6Pmed/0ZoPt+8BKOc/xBKFulxFXuOdSy3MicUa/mmOJzly6+rcwN8NRN0kPSzVosg5FYJBGwKC6GNLLbwg/uxokGlt5rIUOwtQNzQBgbAbwTRjqVbghVmq63i/cd9bRVAM/ImeEOcnkh1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139080; c=relaxed/simple;
	bh=Htkoo/9cO7CIKP0jO4iIc3KDWoevJ0e/Ac9yRQ3UJXk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ZEAB59/7ukatO3W0PBR8CGugrWOGUyQrqLLaTJ5Fewv2oht3sarR0HrVZmyio/eA717st76JUeBQ8Z00TdvDd13veGW2i/NgTzY7vQIAdK76/ucILB9L/ERK2JmZXV/1BDuTZXxvy/5KKh1GNsfwaR5ymEWHuqK0HJiyFNA2Buk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnHS8tyR; arc=none smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnHS8tyR"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c159467cca6so130062866b.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784139077; x=1784743877; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HlBALkHxWRmALUuOT5uGqcGnPT4o5St+F0S3DDKC6sQ=;
        b=pnHS8tyRcY4LQnGkF63YaIAVDoBZUJt8FGDVb2x9aL5XCLttwvNB9lnv/V9sa4r2dY
         PU0aEtr7qmUqFXuRS6VV3+ZIntLLo5nT5r5UmxaKvbr2mqGb2IvC2u46yzhsxP/BClch
         oTXlePNUoXBg/k9mnY6zIvrGeuNOb4hiGb4nSJHaFvgPFlTeJMbJEeTvBlLeaFbxgcNE
         VqlKK0Y4PET+aD4AIYmgZBO3sdh0m62ED2bifFj5wUonEYO7oTA3otCATY8xY7Ptgauz
         lahjgX8ejqf0XvtWnvgA01qKKbQHlrsC9HUsgaZ8Ty4R6kPOSFaviTNULBbT6j+l9p6m
         dGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784139077; x=1784743877;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HlBALkHxWRmALUuOT5uGqcGnPT4o5St+F0S3DDKC6sQ=;
        b=ArG5nbR0u9nmEIAA7y/xmPhCCK/y8xmbiF5nqzFxJlQQY/F/98cdOLH2XwR4R+05o7
         qTyXOUq4cau/D8w3B7sPwHMCT6aIqkeLsG7zb+cucziwK999Sb/TuYIBTuvjpT5nDEwN
         dC20Gj/frKN7GjDRZY+3SUXeDFzCW/7geBpjtBM0eWTimQM4kUBJvHt5Itg3N0CSUTO8
         crjsno+NYKkiJP1qlRkurrDRsAWt7+xyPYYlTCVwXtqdIOxr2xmk0pgwXX08poI8TZRe
         5BePpammjPGuSTvUCOP06+fm7C2TInkNCOeUyXY3uNX3XQn3NqqHLK7U4KwcTp0ULEII
         mAHg==
X-Gm-Message-State: AOJu0YxkCqB79277BvxOQFgM5PixRQ5e6+25nhAG7kCqFw9jYiZByXTa
	ISZKoly2xZfvXH9Ks23VOXJimWtNGCnvAQkH/stu52b5n3xIINkNEImG
X-Gm-Gg: AfdE7cnqrlHmdgRrlBC9LlZMmX3PsTf0cJnq+KSpnpEPl1txlcbks1ttGQD6KJZx4qu
	AXlmDcfH3I9kMNoFxhPswY+jsHhl9Gv08moz2hZyDS19qCYpimWrUxbppO5p5EWGkZJwEm0uWZT
	J0KX8hqv3rTHR1byzg+94oqyjpnxAx/Qx42sRMxmiOi8oMK+Ga+2eevGm9adLQ9YkL2TZG5b5rA
	hikqMQZ6UeQcEfisxHRV9ubXxTbjoyKB4a1lwOnhsP8kr9TDatD/7ReT5Xc19E3QgyWdg8j8HTG
	3Jmz9mfIkxXiAKAUsyaFBZAXruD0R8d7j9JRm0NV0qjABkFd8/6diSfY78VV6sekYj3W3T18SmJ
	oS93Q+Ev1GU6CmVE8VoDAaFHuHw12/AbfEnNug5zvFTP/+iD80IDpTvMGeTDsnE2RU2coXJeV2o
	sQrQfLafYkkmW7BGV85iDVTV518HxTaVyfveN5yf4WdR56z4hKxVXkZVi4CaYLUEiixySMvN978
	tUSEjJSGtFQisazUyBAbX+7fGHkUCtyTVDVIAe+5ityRTXe/2KL3+A=
X-Received: by 2002:a17:907:1685:b0:c16:6dac:a004 with SMTP id a640c23a62f3a-c166dacb0bbmr433642266b.24.1784139076860;
        Wed, 15 Jul 2026 11:11:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1687170e24sm74925566b.20.2026.07.15.11.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 20:11:15 +0200
Message-Id: <DJZCIOHS5WIH.UOBSKB42OXMZ@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Amery Hung" <ameryhung@gmail.com>
Cc: <bpf@vger.kernel.org>, "Roman Gushchin" <roman.gushchin@linux.dev>
Subject: Re: [PATCH bpf-next v1 2/2] bpf: Zero kfunc arg meta before error
 paths can read it
X-Mailer: aerc 0.21.0
References: <20260715172127.2416388-1-ameryhung@gmail.com>
 <20260715172127.2416388-3-ameryhung@gmail.com>
 <20260715173853.886C81F00A3D@smtp.kernel.org>
In-Reply-To: <20260715173853.886C81F00A3D@smtp.kernel.org>

On Wed Jul 15, 2026 at 7:38 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] BPF kfuncs bpf_mem_cgroup_memory_events and bpf_mem_cgroup_vm_ev=
ents do not handle negative enum values, bypassing bounds checks and allowi=
ng out-of-bounds array reads.
> --
>
> --- Patch [2]: [PATCH bpf-next v1 2/2] bpf: Zero kfunc arg meta before er=
ror paths can read it ---
> commit 53f60dae3990fbb436a03cb878e7564339ccd1e9
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Zero kfunc arg meta before error paths can read it
>
> check_kfunc_call() reads meta.func_name when bpf_fetch_kfunc_arg_meta()
> returns -EACCES, but that error can come from fetch_kfunc_meta() (e.g.
> fd_array_get_btf() rejecting BTF binding for a signed program) before
> meta is memset(), leaving it uninitialized and risking a garbage deref
> in verbose().
>
> Move the memset() to the start of bpf_fetch_kfunc_arg_meta() so meta is
> zeroed on every error return. The intended "not allowed" -EACCES path
> still sets func_name first, so its message is unchanged.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index c87e5fec5a857..ddfa4f57016b7 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> [Severity: High]
> This isn't a bug introduced by this patch, but this is a pre-existing iss=
ue.
> Do the bounds checks in bpf_mem_cgroup_memory_events() and
> bpf_mem_cgroup_vm_events() properly handle negative values?
>
> Since enums evaluate to signed integers in C, and the BPF verifier does
> not enforce enum ranges, a BPF program could pass a negative value to
> bpf_mem_cgroup_memory_events() in mm/bpf_memcontrol.c:
>
> 	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
> 		return (unsigned long)-1;
>
> 	return atomic_long_read(&memcg->memory_events[event]);
>
> For a negative value, the bounds check above evaluates to false, which
> allows an out-of-bounds read on the memory_events array.
>
> Can a similar out-of-bounds read happen in bpf_mem_cgroup_vm_events()?
>
> 	if (unlikely(!memcg_vm_event_item_valid(event)))
> 		return (unsigned long)-1;
>

+Cc Roman

I think we should just do:

	if (unlikely(event < 0 || !memcg_vm_event_item_valid(event)))
 		return (unsigned long)-1;

as fix?

> 	return memcg_events(memcg, event);
>
> The validation routine in mm/memcontrol.c uses the same signed comparison=
:
>
> bool memcg_vm_event_item_valid(enum vm_event_item idx)
> {
> 	if (idx >=3D NR_VM_EVENT_ITEMS)
> 		return false;
>
> 	return !BAD_STAT_IDX(memcg_events_index(idx));
> }
>
> This allows negative index values to reach memcg_events_index():
>
> static inline int memcg_events_index(enum vm_event_item idx)
> {
> 	return mem_cgroup_events_index[idx];
> }
>
> Could this allow a BPF program to read arbitrary out-of-bounds kernel mem=
ory?

