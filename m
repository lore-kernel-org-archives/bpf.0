Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0121B1A9F90
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772678018; cv=pass; b=rJ01JuaKu78trNey759uoAxOVSPjGJjSnJoUct33jSGb2ponMdyzExwmMItMezfO5OBOjJbViFC/VGRNi4697zfkL/ULfLKSxBlOBD0RspXa9Nfps+hXpQl2d+YT5a26wyTHbsTGb/v5FtytOb8c2hZ/Ll7VDi55OCl6F/Wp1RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772678018; c=relaxed/simple;
	bh=K9ENe+ZS+qJSovUOmnU+BwHRKPZ9IJnRalUA3D1rjVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4qE3ZbFU4oSvf2Up2506UYsdU8q0n2Im7lVcZx20HH/WE+JdOk7kZKHzUeYlRJenNSqvDqR5r3vcFBGEPL8XVHOpCIMMYOckBzH7kPRQHmEuNeKVtdCNoDdnV8gNmvSqYmh+gxlM2qnfkRTPC+9paAievtC+GiD3AU4uWmS5ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlXe3a3Y; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlXe3a3Y"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7982c3b7dfcso75664017b3.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 18:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772678016; cv=none;
        d=google.com; s=arc-20240605;
        b=KR4fVWDFY1lpiJajm5QbXHIst0/tfZ1p+0D1bvZy+IVfx0cUY98HIjgQQp4qzo5bHj
         wY26bFHzOB+xamHojTlcNA+Euvdk9JauTnB7yKuzo0eThdn2mWk48eVMo29qciVXWIPf
         6YbuC3uC7halWsu5EOJx8XQjlJbGTH1IrP1rW5ONJ/VEIzed/UpxfvUc9wRZacZ8G26E
         jhEzBwkaLjllfcfcKLqG8dsKZWL8prOgefe7bUmtFdbaHa0vfwOnfCDDh22r5NRcbC1S
         a81l3GJN4Op0/t52jJWrOY8HH1WyVaa0q3Zx03eos6WT2TPVufzUGt69BL0AFcBBNucB
         wFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLIDchVytB4hdh+ZFB2ySmS25tHVhntL5EeIcD91OOA=;
        fh=tZrfMP0dAiywRcrVVhpojDxP6chP2xlo4w5pF485UqM=;
        b=ID6HZrkN65r/sokan7qi39pckqeNd8qq5Mc8JbXXcecEQVmS6+FC6ouApd4iYKxqS0
         jR61Ahw3Ij5NAVdlj7jM5/JMpr0XZmwqbjBXDRiajuL6Os18wVyKEfDBvd37fx5SQaIx
         zLyKx3VCwoD50aNV4y1bw8bb1Fjn9qV5uf9GLrrC4Ql1jU2mmONkvFukLtP/WP4/1ca+
         Xmh9SkQrJVWvPOHtpaQjohL71YWsVSvu6MUglwndK1Q5xMiFB1D7Qhmm4lAp0wLeLcWQ
         pjrIaWbxaiy4+QqQrXEtrFZAUcBVEEyEIEw3mPfZvCjGd8oaPunGpmiKphWgJwBBWgvR
         ZdqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772678016; x=1773282816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLIDchVytB4hdh+ZFB2ySmS25tHVhntL5EeIcD91OOA=;
        b=LlXe3a3Y3cYn97S9gY9jMqB9RTWfP1s+QE5JFrc8hcqM0ZhpoGCDR8PxDD/GOz3uel
         sNMX2f540VckuO7nw+9QBeZevobeKqvTClcBm+UYtXXI/VmB38Ar8W5a0PXwUetHkt8C
         Ahn0oZZbbC5jrDYAQxKBleznRHDLeYaOVQQU/VHGErhZ1COdr0BVCzBJ1ZfCZmWHJJRq
         Z/IhV0mpinH31LQonF0C7uLmM+rkUWJru+r9Khjy7X6f2azA8fWSnIIDTq3qgZbum/yC
         ufWwEvd+JAK/Ci6OAjrAFO1RqBMVW2CCylmP7CsZ5Z88FroJrlXdoawI8LerCGDEa23N
         TpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772678016; x=1773282816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XLIDchVytB4hdh+ZFB2ySmS25tHVhntL5EeIcD91OOA=;
        b=TrjSKrQaaiKooT99SVw81a01M0M0yrMWad/OR9ZzDLKK6FYZtI7SclwfU0JaV+wFuA
         BAZ/iNAdPnaq2Y6gCDAfGthJgEpWtquExhbiKdHgfzguSNAQvy0qyXClfQmZv6C9+QQZ
         sgLo6DMD3NP/wmm8mqnzpwp1HUvh+U6O5HB5Zqeb3BU4Vn0eLmGeDis6ur7ZkjLK/mmV
         QaBlKOVlj274Z1EJFvR+Ar3UTtdGNzGvCClMF8uyPNWf+g8poFkmo+xQjjWYRHw9z16T
         J1FCKdspnsqirryr79uz8TceO3SKxJMQxiFr1GPumUxvfdSAXPm2JY/HQTh9yhW3myUW
         TESA==
X-Forwarded-Encrypted: i=1; AJvYcCVpQ4Jvg58k6wS+86CZM8vcupFP+/VbbkYXpYe60/UHy7t+uNB4etg+8knMW1/Aw2BhwKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrEppLmRfGl54KhuLPR725K/edh4pkKwxGMro6Zed0VSkpPjWR
	3bK46CFcR7Lg/E0+08UL8ThHjD82QXsp2vfzxZ//2yt1BWCz9uWDfR2/jJUymXBODft3m07NVnQ
	/Zl/8cOUEbDw/ECKHCs7qObGLBCt4qjdeD5/kB3g=
X-Gm-Gg: ATEYQzyA5eZtbdJAp4P3liP5/n0Q9kKBDuRiUfJZu3XSqFw9+NODUWXR57SRVrAoDbo
	O53u84juU3KjNzxg6f4CARJKs2IKyBrqCpbfIHLUOJocOac4Iai1zl3XmYeID+DicDAG5VCkBRG
	paYe3q+Rb/0CELa+Y3s9zv5YgYlhSKH0OKENOIL+0EJys2K6GjV8uBNSQKSJl7c7Q6vFEojdmL1
	OBFt2vRBNvhCxYmHwfYiNfT7LqihaXL/dzimbtpiTScTKYaSubT6dSouxHbUNXjs6O0LS0b6ATc
	SzVrpK2Z
X-Received: by 2002:a05:690c:d96:b0:796:3d5f:a2c8 with SMTP id
 00721157ae682-798c6c274a9mr31734047b3.21.1772678016033; Wed, 04 Mar 2026
 18:33:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net> <20260304095415.4d5f2528@pumpkin>
 <20260304155742.7b4de2d1@gandalf.local.home> <20260304214447.3e5817ea@pumpkin>
 <CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com> <20260304212802.458b878e@fedora>
In-Reply-To: <20260304212802.458b878e@fedora>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 5 Mar 2026 10:33:00 +0800
X-Gm-Features: AaiRm53aCsDXjaWwJhIMrzV2l8_S6HGgo3u5_su8w8JGRp5Idp54WIy0bpLVxTQ
Message-ID: <CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Laight <david.laight.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	will@kernel.org, boqun@kernel.org, longman@redhat.com, mhiramat@kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 10:28=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 5 Mar 2026 10:17:09 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > bpftrace is a widely used tool for online debugging and dynamic
> > tracing. However, sysadmins may unknowingly run multiple bpftrace
> > instances concurrently without realizing the potential impact on
> > system performance.
> >
> > If this is your answer, I believe we should clearly document the
> > following warning:
> >
> >   Warning: Do not read available_filter_functions concurrently, as
> > doing so can significantly degrade system performance and potentially
> > impact production workloads.
>
> Or update bpftrace to cache that file. It's only updated on module load
> and unload, which isn't done much. There's no reason it needs to
> constantly read that file if bpftrace is being used constantly.

Other tools may also read available_filter_functions, requiring each
one to be patched individually to avoid this flaw=E2=80=94a clearly
impractical solution.

--=20
Regards
Yafang
