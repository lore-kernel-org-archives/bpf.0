Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFAA14A8B
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 04:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375133; cv=none; b=eWAme9+Q5FYkgOGC9BvADJDbO7evvJWza/c6/SqZFluTuEak5b+fWeXqkZxonS6AvyPX74kbe5Wbw/hm7qmRMNDPr5nJa4t4nkNlDeW1oX9v54MaKLnK/rvCJwtkIEaU0sHrrj2EAUqJZfRxamSp7t73HMeI0mfcm1szeHxgxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375133; c=relaxed/simple;
	bh=pTY4Njk75GjXV1BMsPEXibtPDu9XaxfBdUI0uctm/u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQszWb190nE/V8tNmmnMjozEbrnp549p+rElgsY55KHxT7zdS69oGcBPE20ETqA0lvnk5ZaPWkanUJ8QDsqTCMTGvpHsjqkauFlQwBXDVxqdmGv+uuHMFjw8vCYzrCWNVhEeFO4Mui0a59mQl7VHxHppw0JLfH3Ot0sQavauNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TqdGfVCK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TqdGfVCK"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490a76757e5so15245125e9.2
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 21:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780375130; x=1780979930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IivLydf+K0xkU7rLRYnKVmAtzzfK50ra4EAngS5nhOI=;
        b=TqdGfVCKTMf0fk4+uuYpsQoW7+gYayoyfg0J1WYghCsZmwlIIGSO61kcgbxVtMpMDC
         NTIjnna4oIzgpTbH/76+uuF0eOG9tfaAtfa4AOnDGOTcub6OGl26YkU7acllmyMTWRXq
         ffG4G34RuUv/7Ax42CNJpL06ISEI4N8v6fan8eM86UtUXQx1gmbFXcy7n48TwMpIR/z+
         bh3n5IwrjnahCniPVkLW7QYt8i2ET4luEuDoW1ncnUe/XTd38/v56cAp5g62RswiX/TR
         867pjc+IKpTg8hk4lXtbVcVW6p8+hx1LfcPbyjqsQ1wrC0q8sGqT2dZz+AGw7ty3dOgy
         VTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780375130; x=1780979930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IivLydf+K0xkU7rLRYnKVmAtzzfK50ra4EAngS5nhOI=;
        b=P+5ggUjrNYfH0DqDrXC6kBv4VpH+ZRVZ+QYNgiqDbPbKgA266mxmWVzD6edMUiayIn
         X907L7U8h2K5s4d2bYpn/C5WQg+N7kY8E6ysIM9ESrZjagQDtVupGbA/nsSq1uOOtlcH
         e6s72+4IA+8DmFCYian8bvnvUekiRqbpj2jX5oNvFzLyfDYijXn+9JT0UOJ4WcAvuEjm
         BV3WVKxa54LOApBbEbPZOBO8SAl7X6Ty3TAxCR77YJCQSWCQ5Jt7ByqyGCrXJciyjnsu
         SkzcaC3sfRNbkdyiUgNMJs7QW2RJmLEmiM1LGMs17ER3qjq6lRDML1MXXelOuvPryoTR
         ddzA==
X-Forwarded-Encrypted: i=1; AFNElJ/N6oR6kQL5JPCqL1o8yd/7uez7VKo5B6L8OOH+o4zmziu/J8b1FnjhbLOWmOqRQO7HTjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8L8wbAUvXQRJfH/6X70/HdONAMgmnW9iuEW3nbGdfGgKefLiJ
	Hn1RFs0ZjiIedwHtLNfnI44OzkvrOQTht7SyHw+rX/DJ7Moq9ez4lXF6GE5lPMd1paQ=
X-Gm-Gg: Acq92OGz86sjMpCtJbuIJ014CSQFhUTgRCeWsHiGpGgIskI3LIhO8WvraC48b4K58VZ
	xO5uWGBopvtSYmdp/G91ncLIGqGNmOD5toDvHV0Oc7gnIssohR0ZMPuUBEXu3HrCDYSmt4R6CBa
	JD/zVFpN6vZGeC+yK3PsheuxHPgnQYwlw89MZvLHSf581TkFtt1f2mPLXDTfW8BwnBEVmgFM9Gz
	voSfkFfLp5KIhoYaP6bk7Q304AgSo/f9/71UK7GcMFBxzpEnbzLFBqi9MIl+BFWWkSbmQc22aLA
	7JZ9DlUjiVLk8D2XcFFHGeMKp5njRWQuz7AclLK2gjSmLafACw8nDgG7hgsDyLVxqkJXYaxJ1FL
	rfTUGYKli95WGzKPJUL+PjxHBPWQlZ9PXq0dFFOeVL52OcA5ZF1347Fq65Of2raDR6FzG4dpYX0
	Yq19du6oXb24fQ5uhV1gaF3s5Dqv8KlbiHGOOCIGjkcJde73zLkxNk/g==
X-Received: by 2002:a05:600c:4f83:b0:48a:5301:bb5c with SMTP id 5b1f17b1804b1-490a292fbc8mr245917365e9.16.1780375130236;
        Mon, 01 Jun 2026 21:38:50 -0700 (PDT)
Received: from u94a (27-240-75-84.adsl.fetnet.net. [27.240.75.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5f6426sm10479924eec.31.2026.06.01.21.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 21:38:49 -0700 (PDT)
Date: Tue, 2 Jun 2026 12:38:34 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Reject scalar store into
 kptr slot
Message-ID: <ah5czWWfKhE-9L33@u94a>
References: <20260416-kptr_crash-v1-0-5589356584b4@meta.com>
 <20260416-kptr_crash-v1-2-5589356584b4@meta.com>
 <aeFglj36jC4DyiIC@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeFglj36jC4DyiIC@mail.gmail.com>

Cc Ihor since BPF CI should be able to remove map_kptr from deny list
once this is fixed.

On Fri, Apr 17, 2026 at 12:20:06AM +0200, Paul Chaignon wrote:
> On Thu, Apr 16, 2026 at 11:08:08AM -0700, Mykyta Yatsenko wrote:
...
> > +SEC("?tc")
> > +__failure __msg("invalid kptr access, R")
> > +int reject_scalar_store_to_kptr(struct __sk_buff *ctx)
> > +{
> > +	struct map_value *v;
> > +	int key = 0;
> > +
> > +	v = bpf_map_lookup_elem(&array_map, &key);
> > +	if (!v)
> > +		return 0;
> > +
> > +	*(volatile u64 *)&v->unref_ptr = 0xBADC0DE;
> > +	return 0;
> > +}
> > +
...

With test_progs-cpuv4 the error was slightly different due to the use of
BPF_ST instead of BPF_STX, and thus this test will fail due to
mismatched error message:

  run_subtest:PASS:obj_open_mem 0 nsec
  libbpf: prog 'reject_scalar_store_to_kptr': BPF program load failed: -EACCES
  libbpf: prog 'reject_scalar_store_to_kptr': failed to load: -EACCES
  libbpf: failed to load object 'map_kptr_fail'
  run_subtest:PASS:unexpected_load_success 0 nsec
  validate_msgs:FAIL:934 expect_msg
  VERIFIER LOG:
  =============
  0: R1=ctx() R10=fp0
  ; int key = 0; @ map_kptr_fail.c:393
  0: (62) *(u32 *)(r10 -4) = 0          ; R10=fp0 fp-8=0000????
  1: (bf) r2 = r10                      ; R2=fp0 R10=fp0
  2: (07) r2 += -4                      ; R2=fp-4
  ; v = bpf_map_lookup_elem(&array_map, &key); @ map_kptr_fail.c:395
  3: (18) r1 = 0xffff8ddd0bb76c00       ; R1=map_ptr(map=array_map,ks=4,vs=32)
  5: (85) call bpf_map_lookup_elem#1    ; R0=map_value(map=array_map,ks=4,vs=32)
  ; if (!v) @ map_kptr_fail.c:396
  6: (15) if r0 == 0x0 goto pc+1        ; R0=map_value(map=array_map,ks=4,vs=32)
  ; *(volatile u64 *)&v->unref_ptr = 0xBADC0DE; @ map_kptr_fail.c:399
  7: (7a) *(u64 *)(r0 +8) = 195936478
  BPF_ST imm must be 0 when storing to kptr at off=8
  processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
  =============
  EXPECTED   SUBSTR: 'invalid kptr access, R'
  #214/20  map_kptr/reject_scalar_store_to_kptr:FAIL

Note: currently BPF CI does not test map_kptr due to it being in the
denylist.
