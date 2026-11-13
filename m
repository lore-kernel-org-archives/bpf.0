Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571762;
	b=IxJnU2mEDPOGATUj7LDHgGWpwKLtvwKqE3H3hQPAeqwfiZNBOhAQk/WDVk0hGsQ+SGd/
	 2k/FpYsKER7WMYeS+o7bXN1EDT4JhmuVqVKI15VPxoAvjEJG0te+in4znuk8YBuGCABny
	 yaXi8rTyvC/jJ4EKxo3nFGrl9XFBQeSzayidRxstivpcpAkMbd9KLbBMQJILh+o6/sd2E
	 NHQrUUlVAYemBr/3+yZULB6DxyCifzIvIgXTa6yuZOtdDPRo384ZrJl2WB9LOfmzZAhU2
	 Gc3xOnd9ep3QHPrSLXL5nvkgwQwQ+i7UWJ3gZfYA6mtMJaB/QScIAVpPtmk/MqTg8oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=W0PYdNoUA4bnzGbu9dGMKa+fRcl1vynKfI30IciEm+Q=;
	b=LaisP8KOtfGrGrNopxfqAjp43lP/J6OvSO84u5/BHrG3LTFrmiVsZqAp1psHItQg9gsE
	 qpRy1CNUsgc8W7lRpzFP+0nCgUiMG/kndxip63NlpHQtm6wq+vSmXeQfATBWCt66Jr5Ep
	 EcyNahaf8rce5dh/TjJm/57XPz+EXlX6sFpTuykFzmNFl1nXpEviqWmLgkW0hrXgp23KD
	 JlG40N+CXtJXsiPOa0LbAaKkQiNEJL1gWxnyZqCvM7AzLCXcqhkMT0VWCUaV5BNBGqn7I
	 XWG8d2UlZx1ZEZU59tUVHvDG2G3GGMpixH3ZU9O4A8VdvKa9o5LguKdZaQNXWTs/Klw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ML9tn/Xe";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD158606A331
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 12:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD158606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ML9tn/Xe
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so1290451f8f.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 04:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794571760; x=1795176560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W0PYdNoUA4bnzGbu9dGMKa+fRcl1vynKfI30IciEm+Q=;
        b=ML9tn/Xeak5APH3z1K80nwKuszCOHpEP9g/ivI2tRiJ2/6pBNob1wuso++4a8uLU5J
         tEIZdgvPQ9EOkeH2esqRDukr3rU1zuq1/1XT6EultKy18+fEuJoMr2kf1DhG2QejS3e0
         HhUUeW4fYPIfEfcJyDqBMkk+pmHOHIm3FCivSp5tN8to4OAaZ5ooyxV28UeR5hnKGTVd
         cBQXfS6r6aotfjxRnD1DCxUdF9cL1OtpvmZFLXP4Bv/UQcyAQu4KG9JmS4Tk/GWWorrr
         syfrQWF+1o2TiIwRpKl32jQtR0tf+0dOB01k/sMyoXIroDEMHY1U/xU07ndmdcRTrB7l
         Xz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794571760; x=1795176560;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0PYdNoUA4bnzGbu9dGMKa+fRcl1vynKfI30IciEm+Q=;
        b=EnyEnEW0EzSnhf/GAQnTsBsMI8yo4EI1wWpRKPn8zO4Tetu0KiYZw4WtH5Mc5pCWH4
         HMiAudySdQhx48vSlrn/CnjuBqgmQ7azTHDwUVS7QF4sq2bRfPehPxW9Zf95d79MI1u0
         tIv5H3VFmCv1IsM3sIySuRdxObYGcJbEO0Qf0SGkRjjkRb9RypDf+lxuIZcb9eHAMv4v
         QAVuCV9dkOtnuGmh62D1brnid/XY8xclTc4SNHW0IFfeI6tC0RdN86kuBxPiNFy+mgEh
         16v5WiZXQe2U5u5v/Zy+chs/qm37zNlwybpNLLhEcPtUIdq9BteVaOKvnj2k/3lKqGlu
         NXpQ==
X-Gm-Message-State: APuU4Z9wFIDr6u0wc8KCvyRVGHladcictVMfOEbACBcgZmTL6x+CMg6T
	inM42FDxFJgmlvIugRvsL9wPjNyYFqEQhkOvg0Ipa/Y/DZzfbwVbzcg4
X-Gm-Gg: AYBFou0iZu4mZgF+SC+HFvtfG5CHe8HA75nMvWZwnIiWmZpINTPqOJuykNZAHDhcvzx
	pG4zDTtiD3K5GnvheNjLGSI0Ei/7pVdQ5IMdNCdYIk7I7z/qucL0c5lSjKtB5o7Y/YtyOA6givL
	omwOeMpEI2U4xZeeOVoNltU+Geo4AJZrZDWnYHqYRpyHRiZL8jbHuHDwJY/Y4uLl2745mrzKsqZ
	hjfCnOjQ5cC0DSsdjvw7CLSpmB2afx4xgF3L0OYdZFsKwJT/bnV8TNgRVN5ilpne+4PT0QmyEmn
	E0jpzWlnQeK+APXdmk+TTIPkda9QobbdSPbBZBEnvNGR0E0sRTzk2hpnJ9aywIpg9THs7ApifA/
	TuzqkK141JGUTHM53l/ClAsV0qVLk0RyH6leMfPGcampFGzxG3Tn9oHpnYpOgJ8nchcRoQkR5nR
	1ELcda1YAq69YkJgoK2hDB0RsGFn2e6TOSzMxE76bH1sp56Vp/nxVFoVfn2rZmV5+0kT61ViAJI
	ygKeye0iOk8GGLOJwbG2WPBMrJo8CgFeCwArFil0pGclVt27gtkepPvQwkKcsQO5JainhhejbiP
	Ieg/mQPXYPSoA2u8Xk1APMIZ+VVmgXRmnkKtEdBslLE17FqPp4pemsfKkDQ=
X-Received: by 2002:a05:6000:40cb:b0:492:b880:53a7 with SMTP id ffacd0b85a97d-49c6d453ec2mr6261766f8f.5.1794571759922;
        Fri, 13 Nov 2026 04:09:19 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60021375sm4570520f8f.29.2026.11.13.04.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:09:18 -0800 (PST)
Date: Fri, 13 Nov 2026 12:20:55 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com
Subject: Re: [PATCH v2 bpf-next 09/13] bpf: Allow fmod_ret on tagged
 functions and check the return value
Message-ID: <avcApw6Q0_DUmWkE@mail.gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
 <20261113050901.1399091-10-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113050901.1399091-10-alexei.starovoitov@gmail.com>

On 26/11/13 05:08AM, Alexei Starovoitov wrote:
> From: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> 	SEC("fmod_ret/vfs_fallocate")
> 	int BPF_PROG(no_big_files, struct file *file, int mode,
> 		     loff_t offset, loff_t len, int ret)
> 	{
> 		return len > MAX_LEN ? -EFBIG : 0;
> 	}
> 
> This program keeps user space away from a bug below vfs_fallocate() until
> the fixed kernel runs. It does not load: "vfs_fallocate() is not
> modifiable". The build has tagged the function with the errors that it
> returns, the list: "bpf_fmodret_retval:-95,-29,-27,-26,-22,-21,-19,-9,-1".
> 
> Let an fmod_ret program that is not sleepable attach to a tagged function.
> The declared targets stay as they are: what a program returns there is not
> checked. A caller of a tagged function can get each error of the list from
> the function itself.
> The build knows nothing about other values:
> 
> 	R0 at an exit           the trampoline
> 	0                       calls the function
> 	an error of the list    skips it, the caller gets the error
> 	another value           -, the program does not load
> 
> With -EDQUOT in place of -EFBIG:
> 
>   At program exit the register R0 should be 0 or one of -95,-29,-27,..
> 
> The check is static: every value in the range of R0 is 0 or in the list.
> [-27, 0] has -25, which is not in the list. The program above gets to the
> exit in two states, R0 = -27 and R0 = 0. The verifier tests R0 at the
> exit, so flow_join_makes_up() does not join ranges that leave a gap.
> 
> R0 has a 64-bit and a 32-bit range. clang ends "return a && b ? -EPERM : 0"
> with "w0 &= 1; w0 = -w0; exit". That is [0, U32_MAX] and [-1, 0].
> 
> 	target returns   range     R0 at the exit
> 	int              32-bit    w0 = -22        -22, allowed
> 	                           r0 = 1 << 32    rejected
> 	long             64-bit    w0 = -22        4294967274, rejected
> 
> The caller of an int function reads the low 32 bits. The trampoline tests
> all 64 bits: 1 << 32 skips the function and the caller sees 0. So the
> 32-bit range decides only if the high 32 bits are known to be 0. That
> fits the ABI of x86-64 and arm64, see the comment.
> 
> 	What returns to the trampoline
> 	exit of the main program, of an exception callback    checked
> 	cookie of bpf_throw(), default callback               checked
> 	tail call                                             refused
> 	extension of the main program      refused by existing checks
> 
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> Co-developed-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Please consider taking also this commit from v3, which requires JIT for fmodret functions: https://github.com/aspsk/bpf-next/commit/f8abd203106bc3f0cf978f2292148d4a63f66b26

> [...]
