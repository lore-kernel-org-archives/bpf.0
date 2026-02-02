Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81851388846
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055024; cv=pass; b=KbNA7+zQ/ryjcu5J3SRQtMKXS0HMdBvln1Wg/z4NvOYfMHZWJBJdTPxTonRrTOtNGhzhrrYfIxmFBOmnhGwkbLVaYNFUjbWaSr1rVW8ai41H/Leit/slcHc7ieq8u5TR7nkUEkenB2A+Jz7QAX6xvdlhtGua9xpQLcxU4rBDoFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055024; c=relaxed/simple;
	bh=CBIS6bueJvuLSLj8HJsOHo5Egd/VTGHz6S5XCH5lX0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPCvmaSIm6C0XHZotMBwTuFxa+Sp8t1XFetH6iZFzGa/44hw/sfJJ5imq3STMFcfDM6krjcbE9udqmXFShz+ynyuj8wdDnhQXnuTq1R04lI5Py2av403569Hi0kRL4AFhMSBhpdYgHu3j0Qjqe9gaV9cwJ9PU5J7FXNldmlLFoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2bcfDyS; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2bcfDyS"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-432755545fcso2960966f8f.1
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 09:57:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770055022; cv=none;
        d=google.com; s=arc-20240605;
        b=JGvzZkc/Sf21nVRQQBKSpczVa8eCfeitcrQjPwHRYjtxTWqHBkz/I1AjyuWLayu5TD
         5gbQPSwuD/MRA+s1wFAxEXCdR++4B0VhHVA82RWJ96IHAK8+bSwDblGywB+hILS8ZB3d
         Oyyy4tDviqPpBrl0qiHuCXwiCJX9dhylgZ40s6yhGZR7ogZlSKy2daXde58mW5aP9/CT
         0nBQA9c2TKiC4HyRF9ZNzXl6l5xQYOq9lGLnUeTISVwglnFbqLqEr14xayLgKa7j8htc
         8cYKcsjPLd0RISCFt0dlfM3zjDMxOvW0qYD8bLmCm13A7PR8iRqTpUWHqdZrEmgOTH85
         EtpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mDEHGLGJqUCy3CksWFbc0eH+SWVMEdfST5IwIJHkik8=;
        fh=tbkqfNOsXNMwWUCI+SOGxP0oDSvHyfVng2YklND5LYs=;
        b=ZE+XSaj1G57TttHzw3aMiAM0Mrbagth3rlMj/S9ubf1eZU9SWwM49z7jn6ZsSqiNoC
         STyOQwGLScj/JeZ91XoFxmEe7PQhL2FYqbmD7P4Ksz8rMho73lZy2oWkaj+5eukYL5K3
         eIz+XtTxW60tJJ/vWPI7g0dXDBley4yODDqls/X6giioUUQl0RbT6Sr97wuTk0Gc1Z0B
         kPUkrtnPrNSXBAkaDkIh5TXBkFY4c9J4YCr+4JlYWQzTQsLS98wmPUdnRvXjzJQo8VHo
         TnIz+/NzeIPd6s5ApiPqHbAzg5b5i8K1TC3Owv0KsqYCMWTYnEPPN80R1f2urNqoFv5B
         CXVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770055022; x=1770659822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDEHGLGJqUCy3CksWFbc0eH+SWVMEdfST5IwIJHkik8=;
        b=m2bcfDyS2ZOZc1G7MrtVhyFtPdRzlb5KxXZZtFQAZJw5U3l6RM2QyNuLxjGseR1zGy
         A/GjkUVn7pPwtdawMGj+fzPCXjMi/S0Wp0oOJFnFRTFMMvPcGIL4R36DjxyIJUBFAKVT
         5qAj0pZwDJjHpOCtVwSJmUXZAIDD84XNtPszjwCDvcbPRYK1MGjmQwcq5EiL6l6/34uw
         TyJxvSULtB1BRYutBSU2yZAnM0Egp56MspImlXGDm2XyRKq09rcaS5HY8zjgwEm98bU9
         cp0ncnD+TSkU9zotW1Tp6VR0x6gDbjvzlljgHE6lRYAl1ZTOUdttiq2+akY18KmfUdk5
         zeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055022; x=1770659822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mDEHGLGJqUCy3CksWFbc0eH+SWVMEdfST5IwIJHkik8=;
        b=SUei/8vN1sy9ZgWs4czBmAbxx8LVpaxsceK5BXbLqT/ebAaBaZeWXTJeFyDWmMyKy+
         a+3iB3v/OhWY405/oO3I6jIueazhZvyTM7nSA7bGXlUA+zbb3k0UkVIaYrwrhrfJK4yZ
         kMEZx2iiUQ0T5bLjVZ6YFDZhk0NDEBjHGSXq//MhDZW/7y+vM7aGnptuDvMf3IRwmhSN
         i60F6KVx/mZpv3llXZ54Vj8tbHUk++gXPsOVbqK3w3sfm/8ociWHjPEnjQJ5LpRBiF3/
         xJhKAsSoTtFoPVWRyMSvha0718bEUs0mMrh70zvBHVVoGJIzTAQelXwnA5wAuo0VjqUB
         Tfkg==
X-Forwarded-Encrypted: i=1; AJvYcCVy6P6M9EKrCheH2f7heTLw+OeDM9o8k3wr0ACoeVJ9mWOAuIk1bObgO6eC0KIO253xhKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKK1fxMXIbj5hKjlsXlaC3EBJm+zyV+/QKWY26KRyqBDHwkke
	JmLSxdHFCCESo0CtlagYWObonx+t8Lw/M5C43XG17V7V6nYSkh0PndnR5PhGPTipEq/heNm7QVQ
	s4ekn2Y0BFsXWEi8nusB7dXJGyITa9tc=
X-Gm-Gg: AZuq6aKpE+1aBgzC2THSc/vK37anhFBsUyDHu6D+DRgX7FLbm27EPwWgaVr9udy12gx
	iaESt+FXR8I4NRbA9phfNp/v4DVHsj9Q0XJuFLr+dsZAwzFDfN5HjkyiRY9y3IYSVwy/q404HKC
	6CT7P+j5puoLmsCwlHw1dZKmFwgu9T7pFcHxjW2rPeGKhNfBfBzus64ZzWf1MX0OzJtYYRqrWgz
	iOJWzOIKtNhWvUIQoWM0jx+CiYQTri2fucUcDwn0r/wx6a4jbZQC5c17LqboT4tSmkOmEMXoAVH
	jsDgt3IYdO8pW79wQ/X/vrWxboAPLLwnUmjVDtFOo7L04L8e/IHWvA7Eo1lsYbM+RFmuWnQ2
X-Received: by 2002:a05:6000:1a87:b0:431:752:672b with SMTP id
 ffacd0b85a97d-435f3a7e203mr18826439f8f.14.1770055021709; Mon, 02 Feb 2026
 09:57:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202090051.87802-1-pilgrimtao@gmail.com> <20260202090051.87802-2-pilgrimtao@gmail.com>
In-Reply-To: <20260202090051.87802-2-pilgrimtao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Feb 2026 09:56:50 -0800
X-Gm-Features: AZwV_QjLWojZsKQzqgOComDwfj5JZzvvOFxU7Q4Gk607y5vEuZlt5VDX8GtW1fo
Message-ID: <CAADnVQJPFANbYvYYyG3OQdXh4174bGwsamAzD8HZ5f=noS=BnQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] bpf/verifier: allow calling bpf_kptr_xchg while
 holding a lock
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Chengkaitao <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 1:01=E2=80=AFAM Chengkaitao <pilgrimtao@gmail.com> w=
rote:
>
> From: Chengkaitao <chengkaitao@kylinos.cn>
>
> For the following scenario:
> struct tree_node {
>     struct bpf_rb_node node;
>     struct request __kptr *req;
>     u64 key;
> };
> struct bpf_rb_root tree_root __contains(tree_node, node);
> struct bpf_spin_lock tree_lock;
>
> If we need to traverse all nodes in the rbtree, retrieve the __kptr
> pointer from each node, and read kernel data from the referenced
> object, using bpf_kptr_xchg appears unavoidable.
>
> This patch skips the BPF verifier checks for bpf_kptr_xchg when
> called while holding a lock.
>
> Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>

You ignored earlier feedback. This is not ok.

pw-bot: cr
