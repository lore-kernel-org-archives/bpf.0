Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2113C559C95
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113392; cv=none; b=osq1mcolCVSvX2f2ygg9SY3Aj3tpKE2jQujmpsnqS/mM+BT2pUnzcFgZJYfgY6P3oJA1ATbbbg6b3d1naVGK9EmwSwc5kzAEnape9RZ+WYTTbeHBLjCIPtcymk+p4iHoUYFcr555PtJZgp5+vj7jUFExcBUdtKrXGlYHWAHtMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113392; c=relaxed/simple;
	bh=zMeMUw1MDnH+GhKRqdHcW4eVG/uQS0A78FZ+IT9NT9w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pKCmhGgcsH82odQJktohTPeC9CAczYgpCB0/2MlkMbJ2/1JNAwe+yMkJ2e2L9jZvMGQfSofI1puVn6WlupuiSTLka2OJA1EGQS0FirdQWWOeNKHvZpXshFlqZZEdxu7jk/I6se4IZIwvl1tWGEW5LaO5yyAS/vjbwNPADXi8b3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQHZlhT8; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQHZlhT8"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-32ba4885063so186263eec.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 14:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790113384; x=1790718184; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yEBne1gZoOADgou7Bf9As52LYZ3WSpP7dxT2bSnKiYU=;
        b=bQHZlhT81AaEJ8C6BmV3vyBu8hcsLj93ukO6waUuLB3F/yyFUrUEo5Hpdkw9+4/2JC
         fIXVphqhGv9IPv7klt6F46QKWcjCRW8pe5WxP2kh3haVSa31qfjvTdOXFfJdNgrLo3tZ
         c5Wwh8XIwgU4J7oqotpZr4kqGsE7UNpa0CZfRCgLXVPsvQuNtvNFhpys+s5hLOIc1/8I
         9YA9DM7PIhBeDoVFGYaYCLQVaD8tgvgTxtbtgKJCfrIjeHG0qcmWvNzL07TICXwzDfJa
         vqlysdnu0cHONS0vta/Idfa2wCMg3ZuZYczbJHvppNXq52zpXdQaGKemgdav68OMwxoU
         bPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790113384; x=1790718184;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yEBne1gZoOADgou7Bf9As52LYZ3WSpP7dxT2bSnKiYU=;
        b=baYdl5wVNGXrMrRw6AGHkU86rzQGgbT0DjYxDTQHa/tcXBoc59+byqqgYtIoOOz1WH
         B95EH4st88d8iT2isOo5VOvACevQWo+IS1NvO9670wpNCipWrLM+0SCHcfka+qTlWhMz
         PlEbZHQzyVjrliVINe4sr1Rrf1K3FedsSuImzblnjQ81czFzGcZ11IESTa+s76TU3f8d
         xbTykriR1eKtzSRrE1tVA5bwlAyZQsNSEtky1/zaVZluqTd2L5aaxNmKHO8P4+zAv8Wh
         wkpCnWDWQ8uejMCEyFxsjlu5PVsmKINpy6XijP6du1LL8SFaeuQlDCHII0YYA49+GzN/
         Kz5w==
X-Forwarded-Encrypted: i=1; AKwUvBw9/g5KLx0y9dPKyGgQXVD1sl9Y1RKMnjAGZnwRbyNaJnyxkDyDpmZS/jcHg7+fxhzQ/hA=@vger.kernel.org
X-Gm-Message-State: AFuF++kuQwQlDRgwXcDxuL/xowhk1jI1gImYWakOSdi/EzysDtwpUF2K
	fyZD4GRnSvAOWiIC5a1Am6FKnvMzN0Yd2QhY5oDUwl3l8LVbT+lE02Oo
X-Gm-Gg: AYBFou0lCaIV9MFOpwFPydkGmq4cdJ7pfe/mbk+phJLCVUKRqUl20kT7iBE2VXfBMi5
	Ut3uVp2rdJLhvNZ/ko22SWCFC7KX4Qf+K1KtBPvF4pWdV+q4J0eOkaGmFXvZg5AQKO7OrXMGf4V
	cr0MXpVDXM73MmqGNK09MUvorNt9R5w7A5UgbUh1bkr8+iAuJrFQDFDI2cKQNe2BGe+uwRF9c+c
	bAHGWUSmtKxChZeLAX1R/FsmrVqoGPe33n7bMlile1YigjtLW/gRTNgnpzOEXEj6JoZ7OIs/Q7t
	7vo+BaCviewqoljVpQgFx5bG2/+y6cHaHQY3zndzy1kqgsJrzqLbk341VPPmHZ4NtiH+9n8Dnje
	/UyL5Uf1fSAdMqVIylqxkpAxYhQ1T13S7EmcKWiIpekVp7vnGWfeJ6vjfdWZERj8eJXhNMfxUPk
	E4VWgqVi+go2MjLv8XPCMm67BADIUA1l020vCHAmzjo3uxAsaLv5Rk2ltqextoFoqF8EWyi/JVg
	ia78qLlY7ussz+TwpyqYrjkkBjdoXjMMLfTyCsjQpku5zp/E3ggU1XkV0mzXnbW9fAw
X-Received: by 2002:a05:693c:88c8:10b0:334:30bb:5e85 with SMTP id 5a478bee46e88-33e8e699efemr653475eec.38.1790113383842;
        Tue, 22 Sep 2026 14:43:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f4d5:5623:3480:5143? ([2620:10d:c090:500::7:fbb7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96d497e1sm939793eec.25.2026.09.22.14.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:43:03 -0700 (PDT)
Message-ID: <dfcab4681d89c91a8e2c7fabb80f362dbfb2f9a7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/20] bpf: Refuse exception cleanup shapes
 bpf_throw() cannot dispatch
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Tue, 22 Sep 2026 14:43:02 -0700
In-Reply-To: <73a766ca-8198-4677-8c29-29fac8489f73@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
	 <20260921210109.1719713-1-yonghong.song@linux.dev>
	 <d87ccb2d98acc167a80ce894a844abb29ee433a9.camel@gmail.com>
	 <73a766ca-8198-4677-8c29-29fac8489f73@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 20:45 -0700, Yonghong Song wrote:

...

> > Why is it necessary to hand-roll a CFG traversal and a separate pass
> > for this check? Given that bpf verifier state already maintains
> > `unwinding' flag, the instructions properties can be checked from
> > do_check_insn(), e.g.:
> > - bpf_throw()               -- reject if unwinding
> > - call to a throwing global -- reject if unwinding
> > - bpf_unwind_resume()       -- require unwinding and the pad-owning fra=
me
> > - BPF_EXIT                  -- reject in the pad-owning frame, allow in=
 callees
> > - LD_{ABS,IND}              -- reject if unwinding
> >=20
> > I think that would take much less code, wdyt?
>=20
> This is a good idea. Let me try. Thanks!

Also, regarding the tail calls. It appears that the following chain
can call bpf_throw from a landing pad:

  bpf_throw() -> landing pad -> global procedure call -> tail call -> bpf_t=
hrow()

would this work as expected?
