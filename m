Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA1A381B0A
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792267436; cv=pass; b=u63ylGfBuaHMzFyUsUfrOwpYe3zjjNwY4jZteYAGKM/tEyAuiU5ruOjWM857oXC8RkpNJylrV7IEDKUn6idCRqTIJLe3kRYXqEfGbmnHkHNlqNAvK1EQxc6SkNIklsus3SNYbq9tfVJPb4p4Ez2hLENLmjHo1sj1tW3UGMs6itE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792267436; c=relaxed/simple;
	bh=vfp7UY7cSQ1XLScCMQR5XlwbEk5yXRdbuaIpjcUAVTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igvIoc2VNqNjDwyuBIVhnlR1MqUFDhua2kXi9+8to5FOXcrYbKZnkHFyu9JLsErnAzMsx/UuTEdSv8zO0CSLVCrdmulQv0ef++c8wZkTxa9pvE7qtGgj1iCsI6cauA8KJkenckK3d5LsU+x646EsAcW3uRRMbeXMSTFCnv1qPFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5DZf/HV; arc=pass smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5DZf/HV"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-48df4afd489so363023f8f.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 13:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792267433; cv=none;
        d=google.com; s=arc-20260327;
        b=VkG2ZqhPi3WtLcGdjjgl5xXi/WzyeTjrfx4MX9Rr8MPPlHZglQwAgXsr+neVMBHzg5
         Flji7Gd6x6FqY3rcpJeD7VWQfAgIQFaWlArTWUhhYpEyXPq/Juxo3pjH9h6ceYzTWUcu
         9x1twNZZ2DO3Rw8YWileQ89qZrR/IT9m5oPSLHkvA5Y6QPODgvzylKGB8kZ1hKjDAaUd
         XZRyv9BypmJqVpZZ+ulqS1JG1djKiF4SPoTEdpxDTnJarKN8N19ithUaHyUKO+Wb6aPQ
         hhyybZeA1qSP4YSY5W3upqZjzVDfYXQ0pPbYzVV6nZ1mZv28La8/pECEBS/DOLTv926R
         bLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vfp7UY7cSQ1XLScCMQR5XlwbEk5yXRdbuaIpjcUAVTs=;
        fh=ivbNnctzSCEE+B5PWbcRZUeTX6K9jLx8qkGCt1Wj1l4=;
        b=o0j/+jpTSDKjjqa582eUiK5nQF2ZgSj5APxmnuiJD5owriVOFkauVo3eDUNDQLPMkm
         sEg1PsdFH/Rs/u5AJJo07tR6+ASBIZSRLEyGTo/vLl8WSTmm/jS8CsXQDEgStztJQNoQ
         Cem2H6KRV2I4EKLlSM0wrwwuutkFsaAHGVyu7zn5ot49I1Y7G0z1ip6tt7IODSEYG88Z
         pbJj5pyPZBdUKtsS1iEm+D+teyYcRdNcIZWYP2Nyq8l/GszohYRFopI85qmh+TEFeXEc
         9KmDkGmQjy4suHALkk6oU/Ca6BPhv62O3WNMI42JlptYoK+1wi5IEyXdngk0bSsNZKua
         6Szg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792267433; x=1792872233; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vfp7UY7cSQ1XLScCMQR5XlwbEk5yXRdbuaIpjcUAVTs=;
        b=L5DZf/HV9VWA2pprPIaWoK/l0E9yokVwb51jNlw2zfOvJZ37GZy/LkLNhUfPa0z2A2
         msc9Rx58nMa+V+0qa8WNNy6RXl+xvT8hWZ82Ek0XWLXZfnkS6UPxsJ0Vc64LPaYsfsz3
         99/W0Tl355O5htMk2vC2R4HmFC93UzMAD7Zoo6oHSkQgKhzsGSHOTnLtEdcmcDD/G8DS
         VcHRqCe2MLFyJ6vICxMAQITstKeVJnQTVbXJ1zR8qfWnBq08rBzNWeqAdmgkIjlQe7EV
         dZnj/b4fe56tSDdDrVImfS3b3ZGQ8T1lEINhdJulK41sM9IhbBhMKzVVD9Ucuo59Nbuq
         q+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792267433; x=1792872233;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vfp7UY7cSQ1XLScCMQR5XlwbEk5yXRdbuaIpjcUAVTs=;
        b=ixhnBnnb4MdqY3SfpYcgyvRbv42Ysj7qT/DAXgbCTtK0/oQxNXinybJ+bo81oYVzIa
         AOfZDMNXPj9O5V/jlxa60niKTU3qAWgOJmADI91WLhcDixT1rVhP/2aQ1BaKuB5E52VH
         aUMPQVfHCVxRp/dJ8rPWIoYJI0NzPNEGWdzIrTHqW9nA4ri2JIng8FJPIHNu4Wtd+vjy
         0G7kdvhcN4wA8xyWxrBJ+Qs/xdyYgU9+/WCmX0H3MEtI83dmfZODiR45t8neINhz3+pO
         GQ+4vPQNklEe7n5/HbsCegf5g0vqg0bU4v1ajncDMtIEfE4HTYsmgLefOFXwhbfMWKF4
         fMQA==
X-Forwarded-Encrypted: i=1; AKwUvBwf7vkevqneLzttpMya1QVnn2SE37YA1ndWfc3K+Lgo3M5hkFMyiEYumBL4P/T+mBfPPqU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5LYm3X8zlbRBapLigsYEagSgm0kYXCn9gbErVSrsQJ/9keJ6B
	0lYJxnn7fs0ByW2iwVm/7v+sJhunfa3zia0X3Jtf1DRueQD+BerCFlC9ByurcGF4sNoFL29YPg0
	/jI8IdNnsvJEiPQ1cAd0vcS8T8dm06qc=
X-Gm-Gg: AYBFou1SlMPrctu9AEieF7t67hJ4ZMz78ZJSHhCQ/MXc56ejX0VWuy36laS+qqowuJ1
	kwOM56WQMEliKFzv3IIQpsHMgqynIU56nBpEnHFMvaBnG/jnFxKNYneLkxujiiN5wwh3kmLt+Y8
	ChRbHR+vO6GPQJqPXuXIMfwhz+KvXAAZf61kQS2xHnSdhI3VdVf5mVOhp/UIMDbDsB1XdNh7XSm
	6CBZpvXCYaCEXpIGHnqhATn0GffGjPJ+w+DYbn7TMBv+vzDTjWLui+rgRfgEm9Fq2I2nWmzpHRH
	8gbka7NSAh7xxc66SurzUBcQbAKW0uvhH0mL5fvF2EDL/NiCnABQnlELqoeJNJ0RnYZXq9b/0pk
	y2ZpfCZp0mq9qb0nRWE0rZEjV8pcIe0eS8rtMa0ppjZP3L8pxlCVsO8FqIUREfI3yLmC+hlHWXU
	ZdvHBmnCVrEEBUbR/GIHColUhq2cJhyI8=
X-Received: by 2002:a05:6000:298d:10b0:48a:f8fb:cd49 with SMTP id
 ffacd0b85a97d-48e07bb7b62mr4449216f8f.22.1792267432783; Sat, 17 Oct 2026
 13:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261017025129.1914859-1-yonghong.song@linux.dev> <DM7A976G9OGW.ZR7PNBUP083C@gmail.com>
In-Reply-To: <DM7A976G9OGW.ZR7PNBUP083C@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 17 Oct 2026 22:03:15 +0200
X-Gm-Features: AclHuK-7Yc915ISZ2E8QConMG0BMpnKnWs3iKgqjFz9Cw2cckm48WL0FsKhtNv4
Message-ID: <CAP01T75Ldbsew4rarQynmbpOvBxaRM7Lxk_1GsZL_rJFOzv-CQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 00/25] bpf: Run exception cleanup landing
 pads when bpf_unwind() unwinds
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Oct 2026 at 19:26, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 16, 2026 at 07:51 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> > Each frame therefore runs its own pad, on its own stack, and leaves
> > through its own epilogue -- which is what puts its caller's r6-r9 back.
>
> it's v12 and bots keep finding real bugs, I think it's a sign
> that we have to pivot.
>

My 2 cents: That seems a bit drastic to me; realistically, there's
only one bug for v12, the other bot concerns are not very critical. I
still favor this approach over adding a runtime calling convention
that requires checks everywhere in the normal path. Sure, there might
be more problems (with this one, or whatever we do to replace it once
it is actually implemented and we study all corner cases), but at this
point most of the current approach seems well thought out to me.

> [...]
