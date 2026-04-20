Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80508386550
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776723460; cv=none; b=Zhbe0mpXgoHeT6hTKpJBRUysmeSD0+IG4ix5c5oMtelJyy7l8iNu//KJbzb2xYur4LchGQaWv/zJJbJKhX9hu5oT1yv0Os/UF2Gb9tad/jKKPpsLXF38THQnXQMHBHu0JriKggMFdkIp8Tq8v3pEDD+xYYggdylv5LYUnNN3W/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776723460; c=relaxed/simple;
	bh=BZL1sGw6yqkxB/Jshi3qghFAQYgPB4mSAe6qvxY8Rlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZqqURPm6M5P2vLLUFuPumrQjs2GVFxI7CuMrWgU+Yv8IbhjLcCC/VTsRC8q5ijTEDbrb7jUgvnUe4T26hqe+wfbb53p+pF3oDYfzI+ZrIpDfpagjjTRuF/tF/by6msyqg5DcxYgM05ZGhklt2oBBIU7fESPiiApj/Afr0cTCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vkk/CDYa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vkk/CDYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AFFC2BCB0
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 22:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776723460;
	bh=BZL1sGw6yqkxB/Jshi3qghFAQYgPB4mSAe6qvxY8Rlw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vkk/CDYaxyfGrScYnJWfKbdNKzj2Q36F2QmqfEkrYSwDl5UhJiFjdN7IFn917SDaj
	 ebrV1b1T+M06YIiubvIWXvwmx+qZPJ2n1IB8VLcO1Ezfxe29z94VQV7KXAKHyEXRVo
	 3+vi8F/0a3HNiHscPn8q16oqdZfEjWRqvJJ54PPFYZoSE4mbuPDQbnpTOwylp1qGaD
	 aG/nqsUnmttM4OEVqfZKACUbVDW/H6b9FCdn+C/laJLm4xowszr7egdzBfWjuoZ2NZ
	 nYHtHpmDSKBnmDlYdaK0eL6T2gR/LxNEYaAh8N+urHpN2qyPM6/F0OAjm/h32J5KpZ
	 1x7cPIYyWDiGQ==
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899a5db525cso29368016d6.3
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:17:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9D/db5w7jTw9FbHIL4KxCgurtNwSfNjyrzhgjKLHv04a1df6oJjo2p/ECy+TCALjWtrBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWxHdzCOiKy6Swo2giQtyCWeFA9nF4N7k44Bfl1y7jSXbso5SG
	aqeL6N7x+FbiPdXgG5u5NQfaI76bIHd+ARb2M3YKRvH0dXmdo6rMrTsn+nKsgRhiwLvavm71Yd2
	FOfOsMGCss/fdeAwpba1qK5LU+VoEdcU=
X-Received: by 2002:a05:6214:3913:b0:8a0:6d76:325a with SMTP id
 6a1803df08f44-8b028072f8amr255844776d6.20.1776723459363; Mon, 20 Apr 2026
 15:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420203306.3107246-1-utilityemal77@gmail.com> <20260420203306.3107246-2-utilityemal77@gmail.com>
In-Reply-To: <20260420203306.3107246-2-utilityemal77@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 20 Apr 2026 15:17:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW66ReooyVBh2DSFbVfQaze6ODh5erTT4fKVnzCFiHJ_MQ@mail.gmail.com>
X-Gm-Features: AQROBzB53cf0BeraKAEpvXFfKqh-__SsYt3HBp6a1WyZmQ8GWkHEz6SolAP3ezo
Message-ID: <CAPhsuW66ReooyVBh2DSFbVfQaze6ODh5erTT4fKVnzCFiHJ_MQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Implement dtor for struct file BTF ID
To: Justin Suess <utilityemal77@gmail.com>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, yonghong.song@linux.dev, 
	jolsa@kernel.org, bpf@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ linux-fsdevel

On Mon, Apr 20, 2026 at 1:34=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
> Implement a destructor for struct file allowing it to be stored in a map
> as a referenced kptr.
>
> This dtor is analogous to bpf_put_file, and calls fput to release the
> reference.
>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

The code looks good to me.

Acked-by: Song Liu <song@kernel.org>

This allows bpf maps to hold references to files, just like a process
can hold references to files with file descriptors. With proper kfuncs,
this can unblock many use cases.
