Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20843630AE
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789184075; cv=none; b=dlzypykw/FVVSy+OGvwQsBn6g32S59FCPwzVeE9hEk8aTo+pUO4LNkGR7vFeopYSgAVa+1QZy6X2+09FVNZNjjSi0suRGzDOZhLfeyPqKQV2zBWwOliwR9DjJ2cj8S62uYyv8FFPV0mQTor1JfrzJPHODWpVXaTJQC3TQY1JqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789184075; c=relaxed/simple;
	bh=Ax1aQoP0dFMgOLxZHqEjDow+wnfMATAbJu1zfmaii/E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SF3aTC1gX6sJiM7Udxb8x4NoIgCsaCn9SnrFdHAydcm+4gShcNp7wRD4CPjWW1lCPMMEYIxVMQi7k8A3YViwuLeKxqmPuRnxn2BNaRJf+7YosDF9mOPvExcly41KvFsoSINhLY9Nb/XB+aNOuJbdFtncmI/42I0ZLZsfj2JKBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imZWvldX; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imZWvldX"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7ffa69b7462so1681660a34.3
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 20:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789184073; x=1789788873; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ax1aQoP0dFMgOLxZHqEjDow+wnfMATAbJu1zfmaii/E=;
        b=imZWvldXRyJlRi+nkB0lRrq7ZRXTcEaDAxoq/juX2kPQ4y/NvS6hSO8/K0qZzrWvaX
         MJfvqi6gyrbRfxcBrW7HJp7elnFmy5KWDvjhdDvBef+H+LIcJ9o1PLSUDSdVO+dt9VeV
         YxYjyOwnu5Vv3cx6Kpl/TSdZ+dyWkmGy7/nNXfiKBlrwntjwIGtp6LIHHy3VtMKtpwoi
         J60AbD4TsdZbxVlkUrUtLIcPS2M1qFr4hS8pBv6n6AcBur7NlRmXhUEozGsKlEZxfQDk
         X3F6FCO6zToKD4SNhXQ9uGPZahCUiBdkbLr2ieq9flQcyQUY+DUda2IwT50Vo6ZG7go8
         OyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789184073; x=1789788873;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ax1aQoP0dFMgOLxZHqEjDow+wnfMATAbJu1zfmaii/E=;
        b=SyAIqYCAD6oDWQRvrVdmsyNt1U4ctX4mNwrQRkY2t+rJCDWVK3ThUgohSQso8MLHCe
         Wpkc6+Yk935NAWzgaffYmjpYLjqt2n3YA7lH4Kmx4KYGb/lQZFS1bquOXX50N/kWRiII
         160Bk3cHzZ/VZdsor9Rzp3t6RcFJqdj5fYPof3ul7H1dca/0fIH8po7afpm3p0WdD0f0
         aKpAZC5JXtOPgeOQ6pLQVfUsH2IWWWF+IwEc4ki54vfzAmQwN5Ho4SoQ5n1QllZhys4w
         VCBh57B2CdXkNt93xjJeHZ96IAWMCnaDvpSVqq7GCxAdQI+q/Oihk/zpoMy5x9QnY8h7
         cRJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDaer23iwASBBQ8VIw+haEY2BaY/79PzUMQZW+Qs6o9Xc1RbixTxTh3rxLAVouVuk7xmw=@vger.kernel.org
X-Gm-Message-State: AFuF++ntFaHQe3tRvQYvuQyI4EACzR7av6WmIYFp4IiaOFYaR6JZ6krV
	0TtBHwhcrsQdMentMhkxt0Q+nRIbSj/ttcpG2sjgfQWIYFzlUzweKFA6
X-Gm-Gg: AYBFou3eXLPhZ+GzhlzT9ZqNwmkwHbT84OGwTm/7YETIfItjd1q4aRI+GN6vIe4guLd
	fl66/Bcmin9m3CcyHiaG5dbtUlSG0QSFKhaCM4Ra2tqTIX9+sJiCX+yI9rWtT1jg0A6t2LYAhV6
	CzA5c6PU5h3ZQGSmk9j8KJB/nXr9HipgiZrIaOTU5GRSAKr+cZbMbTgRnRi/vCfC+DonQSUB85B
	p3yF6YChlVRe2NFLbqbwhkA4edbtzaAMpPnDmebPWu/2z4m016QO9IQTIwqkbDtzWkVdbzZhgFz
	CM03+fPboa5NDdBdt0h6EoURjMSIgAI7EqV5WNjdZW6+LQ2UgVTAohX8XuzOBItYoTP4dppAr2y
	AIGqfYaeJNPGKq3WIL/aPIEHxXmFVs8M7s5MlVGbpAAtP3AJV/4Hqa1DtblwZ9PhBsbrkXLZywk
	hKyrTXYD5Wg/JmyD06c6sntK/f6Eud7rAf1+nqLqyHe//2WSBNIXTSFXaBbUmEbGSYIMML/WYKf
	Zg+43vd5/D1zUNI6BE2q9D6YbKG/sc4/4agQy3zeo0MCBA5nGZ51VSz6hE4UofqXz8=
X-Received: by 2002:a05:6830:4390:b0:7dc:4a43:fb5c with SMTP id 46e09a7af769-803ff332c76mr6187435a34.11.1789184073395;
        Fri, 11 Sep 2026 20:34:33 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f3b16cdbsm4294182a34.2.2026.09.11.20.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 20:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 20:34:31 -0700
Message-Id: <DLD0TJERTD3H.31KZTRXB7IYKA@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Amery Hung" <ameryhung@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Puranjay Mohan" <puranjay@kernel.org>
Subject: Re: [PATCH bpf v3 1/2] bpf: Invalidate iterator-owned BTF pointers
 on next and destroy
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260911084254.3481508-1-xyx2021@mail.ustc.edu.cn>
 <20260911084254.3481508-2-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260911084254.3481508-2-xyx2021@mail.ustc.edu.cn>

On Fri Sep 11, 2026 at 1:42 AM PDT, Xu Yunxiang wrote:
> Open-coded iterator next kfuncs that return non-struct pointers associate
> the returned PTR_TO_MEM with the iterator's reference ID. Struct pointer
> returns take a separate PTR_TO_BTF_ID path which omits this relationship.
>
> This leaves such pointers verifier-valid after their lifetime ends. The
> task_vma iterator resets its VMA snapshot and drops the previous vm_file
> reference when next advances, then frees the snapshot on destroy. Other
> non-RCU struct iterators also release or replace their previous element o=
n
> advance.
>
> A trusted field derived from an iterator result can also back a
> resource-tracked object. In particular, bpf_dynptr_from_file() does not
> take its own file reference. Losing vm_file's iterator parent while
> constructing a FILE dynptr therefore lets the dynptr outlive the snapshot=
's
> file reference.
>
> Associate non-RCU PTR_TO_BTF_ID results with the iterator reference. Befo=
re
> modeling another next result, invalidate older BTF pointers carrying that
> parent. Do this before constructing R0 and for both the ACTIVE and DRAINE=
D
> iterator branches. The existing iterator reference release invalidates th=
e
> current result on destroy.
>
> Preserve the parent across BTF field loads when the result remains fully
> trusted and its lifetime is tied to the parent. Do not propagate it to
> MEM_RCU, MEM_PERCPU, MEM_USER, or untrusted results, whose lifetime or
> access domain follows separate rules.
>
> When bpf_dynptr_from_file() consumes a borrowed file carrying such a
> parent, use that parent as the FILE dynptr's lifetime anchor. Reject
> iterator next or destroy while a resource child remains live, requiring
> the program to discard the dynptr before its backing file can be released=
.
>
> This issue was found during BPF verifier testing with an in-house runtime
> semantic checker.
>
> Fixes: 4cbee026db54 ("bpf: return VMA snapshot from task_vma iterator")
> Suggested-by: Amery Hung <ameryhung@gmail.com>

Amery,
is this really what you meant?
pls review.
