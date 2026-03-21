Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B2257825
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774119234; cv=pass; b=qOORF9sxslD04UgvesuSJIjfhoZKdy30ZhqyrR4P/C0Wqb9857thH3pR+JUflF0x426bt6oFXBvXH91tMAoMdmXND3XatpbQIFt05OkcNfEeJHKGyXfSY4SvAppwYwIprh0atnd+L8xBt4KUP1+3X8rIB1THdpVA0Fa2NAuqn+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774119234; c=relaxed/simple;
	bh=GqT2I7599qRcUcaDV8ky6DpS2ijqtrrtIgx9J+xnzfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ua1O18lTJPUWu1ojSxIObWUzUNxUHvbN6b7Fg+MQRoBKNaCkCvKHSERDRvny06A9CBS7pwCSSE0H+PnNiKIB2MHaknjpvAQL5pdFS9msn0kgyaA+37uvrsIBaHCQajsZko969Ptt5xwhwjmSS4E/blonsOP/L/oB9q+da8f0nyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZBzV1Jc; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZBzV1Jc"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so27590115e9.1
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 11:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774119231; cv=none;
        d=google.com; s=arc-20240605;
        b=cKVq4M5NX30nVtZ+qppXfabLvYtxD+m8MHx6AEgYB73BMSK7IqYX6yEZ2ZO5BMTqeF
         hZyJZ3R5INXyVopm3WZGwAwssBwun+7tSg7G/xci3H240mRMQy7l9hJiF9AncoOSm8W9
         ZsjYp9lmJLf+c+NW3iuT80TWOrJHPmEKYIbFxOBNFAMUlZkGoUx/eMW9vM4fOO0t2mxB
         8n8nKmCJjvmF/4M8FuxPYAZUbd5RFCczLBn0I3g+KQ63VoMNuYNKf/8MqWKsQB8ywHcH
         snC3/kKSAinrZABTTEA/XqxRDL46TIth3JxxVKHFpNaDch+7hX6piH0dH0m9mhmibbod
         9E3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m8uyc+/xQq3grziZE9amcR4dWkQz7YBuMlklOcPkTxA=;
        fh=E/Gkgcv/YAnprMKDh2uZc4zcLKDoUQXr1Y2/U3i097Y=;
        b=Lgo4NGI33hVCsGzFhLIc95SEkVC1AMqdLA+8pfK0rfSfX8+oLmSXOjneo9DCv7wPJs
         fZZFp7PU5qbFx0+5obzOWw+JJcB4pqn34hDyMbwChUph42H740EkdpPezq+tpXvoqfP8
         cMH/P25s0mYEXc62w91thl4LAcXP5rfbkmO7Xg/59VpPqOejAgJn9fpX1JbNhUw7DPqo
         v7NhBcQQxDPIpESuUCUXE0xwY/8z2tkiWk698sHRqLx6Q06eOtSVvqIs8RkquQPFC2sU
         fEOhyY/a2pja7mn5o+oXiaeTumOn3MmxO4/aa7QYuozZ1asXB6Xp/MlPRq+lzr+s4/Bk
         GVmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774119231; x=1774724031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m8uyc+/xQq3grziZE9amcR4dWkQz7YBuMlklOcPkTxA=;
        b=cZBzV1JcnNrfqA1UgEZOtFBjyLSZHlHAn6x7znx3+2cv3qCtrrrMdSNC5Xn/hlTKQq
         1dX61eX5ZNp4Gi6wctLjxpUKqHf/2xeO4SZzIV7QC2eMGrhjfS7QozbDj//HOdvN/+M5
         CHlCqE/7+Z0fgqxz9vzLsh/nByMiUOirPBGDLj2Uvml6f1dmTUXWTK0AB7A/yTOvGV6a
         oA26rr0cVkAbIGJCMNHTO83KfP7P8P/GhwuAKM6Cy6MsIFkTkFlSXMmrRhJoo0QvgazM
         JkJeC32SLzVV1vndDwV4DJdIJn7tPJcSOx7DkcqrqJosVA4pM26L1zG7L/hVn/29Lq18
         HA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774119231; x=1774724031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8uyc+/xQq3grziZE9amcR4dWkQz7YBuMlklOcPkTxA=;
        b=Wm5+Ca1GXP8YholwO7/x4n9HrE0J5JY+PfAZW+8+EjvFhh9XwRRO2egU3mB/7p5/ZG
         SRdyu7+vWYse6sc70JVzUhYPYyiSYyzfJPexjzq+FT2Mj7AxjyWzzM/URE2SLG2MxBKY
         rLpiM6ARzXuQcTFZ6pGrLRCxY+gV575sO4Fq7zW9DIzTUdqRLm99Q0Yqa+wA3ptuO+MF
         xLa7Cx4Modh+d2rBa4TqjCTknpzso5Y1dZJS+Mw8mNrHaI9zFBUu0tPQ/xKA9J17qVqY
         CvjjD+2EIhzw2J9ZAnJ99vfcz3cG3Ted6I+j5oS0u/LHTvSsqMESN2v7JqzP5BpXAMue
         kGcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdcJudAsKE2Jqw5wKHVBgSJ3AO+YVsZLqZkCIBdOQF5m7MwUBAZYPrEieOE+d6pHiSB1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKbczmfbqthvRJps5R0KCPLfZRNxZE7ZF5exQE1pdtX1SBmkG8
	dvkyQR4VCzFG/yNGkSBYgPrk7JGHclKhU5fAuxNaNU5QwTEfZGQ8WM4IM4YzDn1iHO0rBweFo6J
	Jb/0V3F4psOznwjTTJUU/EuDvdQLq9CY=
X-Gm-Gg: ATEYQzyGZDhO6aLdFE9QkHPSHhrju1uwOHubtpJbIBYLa+0fCJEr7DxKHh/VXsdgKxy
	SuVGCvU4YbKqGEGy4dLMgKYbJc5IcV9Ad0IeQmuZJtOLZAx/40MkecQSIIKagFYvcBBpbT9VBD2
	DdvOtH13nwWytl5ToydvM5HXjc/i3do7LwQPm8vuLORPLwJz1SxAWmFAvZSZjGf2oPxHOWaa87t
	UDc1Ltp34FkJ3O4PNxvvt/KJfmhQZxoF5h49V1xWMR+yHY5eubtkORJZmci9uLLYv2gnHWzqIre
	2+UaDFfPxAtoFw1qI4m2aZQGqB/XFd+ZLR81GKLmuXLjRNu7udINbqIYrac=
X-Received: by 2002:a05:600c:4e8e:b0:485:3e6c:aacb with SMTP id
 5b1f17b1804b1-486feda8c69mr100862535e9.4.1774119231291; Sat, 21 Mar 2026
 11:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320000809.643798-1-ihor.solodrai@linux.dev> <20260320000809.643798-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260320000809.643798-2-ihor.solodrai@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 21 Mar 2026 19:53:15 +0100
X-Gm-Features: AaiRm53ySB92iu2gexh1w5QJF9zfdI3jdtxw5fknhOF5qatb7Bo_IjwGeVFLeEs
Message-ID: <CAP01T77mGPmeK+FsWc3TXayR5yOKO+L9eTtpELRAJNwWHQPHuw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add tests for bpf_throw lock
 leak from subprogs
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 01:08, Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>
> Add test cases to ensure the verifier correctly rejects bpf_throw from
> subprogs when RCU, preempt, or IRQ locks are held:
>
>   * reject_subprog_rcu_lock_throw: subprog acquires bpf_rcu_read_lock and
>     then calls bpf_throw
>   * reject_subprog_throw_preempt_lock: always-throwing subprog called while
>     caller holds bpf_preempt_disable
>   * reject_subprog_throw_irq_lock: always-throwing subprog called while
>     caller holds bpf_local_irq_save
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
