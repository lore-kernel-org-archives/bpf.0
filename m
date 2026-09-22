Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1377527586
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113669; cv=none; b=KX4pfvUtax8+qMGneEy6ilDlDrVpNTy0jocF+64iPHwc0n8p5AF3x1KKrYPSsEyqnFKCEdi3GiCtJEWv+6zVJy4uzqopjKXxIMRJW7f3XoeUvO612XRsfpOpp8Oh6mh54Q22DwMih6sBqFVs+1hiIOfA8EkNK3vr51J/BDyt6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113669; c=relaxed/simple;
	bh=bha2O52MWykeNoyPPo0Qi4ZICr7N4jh4ov3z/GYNXOU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=bgDwnliLZhgzDaB9RA0a7tzqGCUPpbtPDQABKKmpYt0c35Xn7UX3PtujGUG03VgJKSvwW9QBt7fMwqtGW0x/vmUrGtqFcgaYVH7rCXw9gAjqbq/r7+9TjzsasbIbg5IepBJvDObhsvfRL2l4YZLiL4Ev5iqhi8+8GTLKhzAU8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oHSQIqc/; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHSQIqc/"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba92so275197a91.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 14:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790113655; x=1790718455; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bha2O52MWykeNoyPPo0Qi4ZICr7N4jh4ov3z/GYNXOU=;
        b=oHSQIqc/AfYqZikngMyTzQXPbpy2iy/iNwyyH/lFMhPar+lttZxij+AtBxGszWufQs
         IC32QaW5V99UK8/vzNCJVFOuYt8nwu587B+E9Y7WRiZas+mi+Dim09ad/zJqg1aZPY2u
         IEL8u3/XW9GJJpumfzumyDmvHfkvVfuDWSXbMtLPsnvkxGRtS7Io3DNAX/U6E9lOQ5i5
         arDoRQEZkCAZUDeGdAc7RrfAxD10FpC/MmFzn5QUs6ZHFHPerTP9AGvMDyP2tagLIksZ
         aQSbQs9UiLaIp8CW2DjaYisCs2BkSf1N/XQfbMU6g073CXh6NtBQgpf3hfY4qktnpO3H
         uLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790113655; x=1790718455;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bha2O52MWykeNoyPPo0Qi4ZICr7N4jh4ov3z/GYNXOU=;
        b=ctniCuR6Rp85GurlPDa0+pI9Mo8fESo4WbJIsI4sBduHo57YTHWBZ1wDW3oyvxAVRf
         TW/jMMoZ+sr7MlBzDpR58QoNZdf19Ez6pq444YdlgFh/BtfHQur/M2JePZz3nqMT3P5h
         q2RxEMYBtjdogB1i2R+q7nZeLhmSOwLdYHROoITwUgtnSfZcO5tGk9f2Kl/+aOT2fWzr
         6LrgcwVkPlm6hd3egdBlpuaub880o7QWoSY0KCie5sNfQOn8F9o2PNwNBLhoULJZ6tYS
         D2979C74kWKEaLw07HS5+kPILgHmAXg8DbQvE5+QbGYI+gu48ZnyNOma+uAcuvuDeH66
         0QVw==
X-Forwarded-Encrypted: i=1; AKwUvBxDjyKiDKLeFBi/WJup6V8cv4AdzYDK44uozKf15Xbk3g66pcuZ1okQaC9BTl9t5J7DEsw=@vger.kernel.org
X-Gm-Message-State: AFuF++k4OgnBMpreTVrA/QCFV/Ii/vp42lPZFzyCtHLJJn/zv0UR9nK7
	PADSrWE9AO6swf3jv0KEqAHk8itYez9uwY22wJPsyMmn6hszVBXAmTzy
X-Gm-Gg: AYBFou1Hxo6B7EoXcC9VrjFXJ9+xjtZ1LriXLLJXNXC+lLrkSxmw9g11v2/xdhk3IGi
	ACdUwlaAbHYu46EwC0ynmOPUXkJ+exhN5TXOpwnjjzln2S3PRKG42EJ6NNVdz+o+fuiut0cRLK7
	iYcQ+3tzqaRCEqu+QvCf9UgATc24jr5hMH6MfXLbDUHOukcbTn7I5qRGxVg6VC4CCPPctprZ2cZ
	7qprnJ/RZDXGi+g70ylPyVG/0VtFdDrVlJxZQLA7vi9tf2eJlT5nSaKcFXdMiU8xJBpCi6JoL5D
	xgd0JwJ0ZDuHEm/DH3YoHk4sRziIOkFP8w6ld+k2wzbIhgcyJKeU7u0gk1/HdXJJIlrjpubOCwq
	s795RvES2oAbmuO+UUuqqR323jdj2pDzMoECXTI+A6MR70QKT2Z4KYqemAyNgBn0MZleV03SKFh
	EoJGHT6jrBg4Z8djT5N/RDzURHMFXZK0qG3KV8GQhGBQfrg52jMPw+Jb+9n9uO2utX9LTDyuMHP
	EXewBag3OiZHZOHvB5ZmB7n1QjR211ublmdd1KUFctI2wSPC9/DRzsjf9+rgOnj0sICsipu107E
	L4uEAoNl07TLWg==
X-Received: by 2002:a17:90b:2250:b0:39e:6a80:dd9f with SMTP id 98e67ed59e1d1-3a07e614155mr634683a91.38.1790113655022;
        Tue, 22 Sep 2026 14:47:35 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07db883b5sm1250130a91.2.2026.09.22.14.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 14:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 21:47:34 +0000
Message-Id: <DLM6BVU1G0V3.29T5BPPZTZ77Z@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
 <7eba4eb055e15d5c78f463d013fa98bb21d7b494.camel@gmail.com>
In-Reply-To: <7eba4eb055e15d5c78f463d013fa98bb21d7b494.camel@gmail.com>

On Tue Sep 22, 2026 at 4:27 AM UTC, Eduard Zingerman wrote:
>
> Total size of executable sections for all Meta BPF object files used
> for CI veristat testing is 10Mb. Of these there are 30K non-helper
> call instructions in total.
> So we are talking about increase by 8 * 30K =3D 240K ~ 2.4% worst case.
> Note that the instruction encoding optimized for size already hearts
> us in src/dst registers department: we have no room for virtual
> registers, which would have simplified e.g. register allocation task
> for ARM64. Point being that optimizing intermediate IR for size is not
> always a right target.

I wasn't talking about increase in bpf ELF size,
but the amount of the verifier work necessary to double the number
of call insns.

> As Kartikeya says in a sibling email, I mean generic verifier
> capability to accept any program by introducing runtime checks.
> Verifier's capacity to infer safety conditions for various
> instructions is orthogonal to rustc's assumptions about landing pad
> boundaries. E.g. rustc/llvm might infer that certain memory access is
> within bounds and optimize bound checks out, it is not a given that
> verifier would come to a same conclusion and that some landing pad
> would be declared for an instruction.

Replied to Kumar. I don't think the verifier will ever insert
runtime checks with control flow at random points.
If we teach rustc to insert may_goto then it will be done
at rustc/llvm level. Not by the verifier.

