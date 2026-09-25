Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F1175A5
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790294696; cv=none; b=E1VGZiNce+UJnZFB8UiVnsgqQZF8P/v5BcvIcuNNNTlyms/i4ORk8d4xpxycpXulWlKK77rTUafUFpVrzPKJQ3y1oKnJNXg4ps4yQbeDdYKF7UzoK6rTM5Mtf1/8emYPQiJlAPKN84M0BwzqPucccNbwOFd4tgqQgpO+7sTTHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790294696; c=relaxed/simple;
	bh=rAvKWZrxLvgCPTLvJvB1BAkWD9OtTSNteVT1S3SD1g0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=tF4NPNGARh7IrENcW9VK/XqQh4Ksl7u1v9O9UE+DBOP/1IxWyQoFajI0ACP1wAdGTGmxuuutCZky0/S3LQT5VMTheFFLmDCo/i87m7/zLDzYHWGhk6cP+V5m5nCw2tSFOMeXf09mB+3l3PXy4BdsSi/CV+tZV/XmMyTGchWeqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQ6yhhr8; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQ6yhhr8"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-880483985aeso7773b3a.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790294694; x=1790899494; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cigb57ggqvOPpol93ktV2mCf9hAKKRb/9fmR4jwfSd8=;
        b=bQ6yhhr8xw0JoCSLvi7BjkpyvuEjIGrStgXc0n1xoS6t/I3+KLemh49uEsB+8+0OAa
         tfpGFsb+EXDi0A1OdD/aZxDKr0bX1sDyEc5Oq1qsxmFc8jzUm64mNZcX0JUZBNreY8oo
         rD2RIdffhTwpfJWWHSifmgQbpU8QOV6KjH4M4mPe1gA1DpI2Ytpr5DY/msycS4v/gU8D
         jxspBVCewDMT15V6u9JKCimTEOgVkbKKvtp4J3uOu3V8LU5EZ+9a7rVH9itq7E5fEOO+
         im8gqmfRqSLozuTzovRDxuwgM78BeWPfrlDqq9X8A2xCed+G726Q1H9UeUbr4aj3TdV8
         Czvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790294694; x=1790899494;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cigb57ggqvOPpol93ktV2mCf9hAKKRb/9fmR4jwfSd8=;
        b=iHJJjMYgJWymSpPeApGWRXo/76R+YIqHGJbXeopIoWeyCAdXNxDC6pg2/B3R/PjQrx
         9RSidK2XNzrUs/PpYSYAMF11Ay/rffuzItMztpH/5pxNT+6514vis+F/ZBvVODAcF721
         NjZyOxdd0YLAOpSgF+t0Ds+WIY4xcAkrU5o2RXNdYwW5/IMIDU0PsVCNFGQQlgCA4dMr
         zpREFWE7d59ziqswELyeYIasunXpuWLRxlZtqVWVqYyKGtJ8D5iXPwygl8NOhXnQG8m3
         5SFYKGAhdpC6OnD21Uu+8oVS2lZg7T/6bTzByQ4RueJ9oHl+d6BkqqyRZPa6JavNOrDE
         q8Vg==
X-Forwarded-Encrypted: i=1; AKwUvByy0c8KVbltdDYcy7jPSexv4/yJE7O+nDvgUl5lpMNkoL71zw9QLuSe6C2hiduVvSYclgM=@vger.kernel.org
X-Gm-Message-State: AFuF++l+awmeNvOqMO2+Dqn92U6ahT1RZ+rLEF7iW9Raihh61/BCcRFR
	dAitLVmHSLp/GHoyfcdvdN2sbl6s3nsjBquBdcC7/3BIPABdrpqJPvqw
X-Gm-Gg: AYBFou3tC6NeD0lGim8LGOjb4LP6+UrKxyfap03ZZW2ePOQoy/8rATbQrF6mpQtYyup
	+RhCXfX4Qcsjja/HjjzImipHxL0Dkh85qzAUg/gcN3nngQms1I+Qcq9xLzrUeVfIjqJOmgE51vd
	maoidUSFYfc0KLS8nnIqBsiEul+eTW/X6aSyv3/3zpFcN2KHSLE2sVXSdMeP7pOrks2gmwDTFxX
	OcplAaK0uMbn0bjSMIYLOTpJ4wgWut8Tp8Eq/u3zHGMqUFFEU/5wImBJVfBp1o7ZOis0a/jWLIS
	hbOwmAsHQZoGTW7lwiUzGZ3v5pWp6vkWd9RQEhxgbm0XNJAYYdxvach4nvjFSk76z1UbPt6tqyI
	KQKrA9gdnR1cCNfH65K8jWAidMSEQLbIGDyrbcWw+i8gUUz7OUB4F+YTdZo5Nf4NRNdOwGnTbOu
	38FnKYPAUrsm0qGHs/yL4tglnuxGvg1Spu9NFNY13DxrCp/DnUjTVEbYHtWWrepOp8gx6vvZSRh
	FBXEoZdRJrbNe2sDwpLtNAWpyY2fQZut1bOP+cyXH49rmSUKV7i3qqv5X7XwJ0eNeqQuoZmkfDq
	S60l
X-Received: by 2002:a05:6a00:4650:b0:878:34d7:699f with SMTP id d2e1a72fcca58-87e9b79c67fmr3476778b3a.47.1790294694409;
        Thu, 24 Sep 2026 17:04:54 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fe82ebc55sm285808b3a.4.2026.09.24.17.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 17:04:53 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 00:04:53 +0000
Message-Id: <DLNYI40PF2Q3.1KYC8MHZU2VJ@gmail.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Eric
 Dumazet" <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>,
 "Willem de Bruijn" <willemb@google.com>, "Tenzin Ukyab"
 <ukyab@berkeley.edu>, =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@meta.com>, "Kuniyuki Iwashima" <kuni1840@gmail.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 3/8] bpf: tcp: Introduce
 bpf_tcp_ops.{enqueue,dequeue}_rcvq().
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <20260923213719.224838-4-kuniyu@google.com>
References: <20260923213719.224838-1-kuniyu@google.com> <20260923213719.224838-4-kuniyu@google.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 09:35 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
> +	/* Call bpf when the TCP stack enqueues/dequeues payload
> +	 * to/from sk->sk_receive_queue.
> +	 *
> +	 * Only bpf_tcp_ops is supported.
> +	 *
> +	 * It can be used to adjust sk->sk_rcvlowat and suppress
> +	 * unnecessary wakeups before sufficient data is available.
> +	 */
> +	BPF_SOCK_OPS_RCVQ_CB_FLAG = (1<<7),
>  /* Mask of all currently supported cb flags */
> -	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
> +	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,

can we drop the flag ?
hdr_opt_len() is called for every tx skb without per-socket opt-in.
The prog in patch 8 already returns when the socket has no
sk_storage.

The flag is one bit per socket shared by all bpf_tcp_ops in the
cgroup hierarchy. When one prog clears it the others stop getting
enqueue_rcvq().

Then sk_is_mptcp() check in the kfunc is enough and there is no need
to touch bpf_sock_ops_cb_flags_set() and TCP_BPF_SOCK_OPS_CB_FLAGS.
