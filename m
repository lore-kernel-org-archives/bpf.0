Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6843ECBDC
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937147; cv=none; b=ucetiI7ejumR3Kf66lE/7ZHaUOXOXaOheIbToYSYUa2TwDrNNY7udQYvzPRgL5jzw3UtKLqxhFRd6RA0kS91RcY1TP8qBa1QpOlodblgNInYcPGj7Wy5AvcRamXiR9Mqwi2sNUGJi01wiQfCgNEx5AoYiaVSrBFJy7iRDq8XMyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937147; c=relaxed/simple;
	bh=9IupZK1aSPF3j6Is7WHGatau6bo9ijtXvxM6V0JcIOk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DwvS8HJlsLI1c0DcdObZmcrzrEW0iva+RxbFlEntOfi99LuXqnTN6LpSPxJ1A7W9h438t2aFxy+HGjseev8YCgLGLTICOVRzNauNZRpkolSVvWsMTy/L/HkTyWImXbJ/lTKT2SrcSIalwlREUZrbThUGcsGYwDQIYmINvYN459I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=bR/3FVE3; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="bR/3FVE3"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89a0ecbc713so12432876d6.1
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773937140; x=1774541940; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXVPxAJl22yrm0f6eePf2hpwyjNEEoD/G0yxYr/XfRU=;
        b=bR/3FVE3hvjM1meBd6Ue3Tq6n4VepIh9HyrYYEB1GRCWtrF3SNC/f6ZrTNbBug5shz
         dddLhvnxRS59scTFQ2lrA+9/ENBLik35rsHZYpcQRwIunNtjwBddLCAy7G2JXgzl3jII
         gAE8exQPec1Vryidqww/JWvwmeUH10Jcjx43g7rdXAeZlz3hFuGYmG52XRL3PWU1oUcW
         N2GhmCY28miORq0Fj2sxoR0WqieibfgjVi/2yqBqDNGtNLOSy+HMRMAAW48iSZY3s0cZ
         LpOpV8X/4QKZLAEYBRxMv5epTLf7CX8MF7C8fPDoepn8vKALGZIwlKeUiuQVXQSlSpM2
         KEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773937140; x=1774541940;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXVPxAJl22yrm0f6eePf2hpwyjNEEoD/G0yxYr/XfRU=;
        b=oH0P5f97gfskFpsjGdqBiKaUh7R1+e4G04avmAnqgkHFcwpzSH5MSYrn58XPd7BJB8
         RZo/VU/VPJOV5R+Zx9jFP1Hrqa6ZEZooBUSESwdgyXrBb1P4HQH+ViGHXPrduMw7JO6C
         JwBIA00bSvHXnvMvJaUwX4tjtsDwBWI3uwQxbnGlukrChQcAAUU9YEXwzprRQLdPQN42
         rrTpAY1mGZp6ljRxNZ4H683FgZtiDsvNupoiYDOWHqKvxdn4ECo9buaU3/jFTXkYkX1e
         YFDSnRYzy48CEv8C+JaGSJGOovFaaoNY5eRVNMFECslgeVW2/zItViV6O7u/fVA7ynto
         eeGA==
X-Gm-Message-State: AOJu0Ywxc+IFsp+MhUASmRw3mybaUgYFB19HknkMRKHPF9ga2BVBnEPL
	QH1FJnC8/I9IK02ntOOYsJ1vRG49jynMdnKeWKjhvtG57TNZ8wtqWYf10UJmCng9tMA=
X-Gm-Gg: ATEYQzxGXr5VsZQdGyF3qKUmUxYNq0GT6hb2WXBmP+4NEh/sqcIBUP2sq9LpYo4aMeN
	vRc98apFPGW7anI7CQnaMFWzwMPzLWbVACOuMJJCptkQ60RJzyASouCFLc46YRoAIb4tq+5PQCQ
	8FfNFclqyBtb84KgHwkM4rXoxJzwKG+s6Fzl85+Y4EwV3+Aw+ouliEVPN5Qg2dPNDEVefaIlPdr
	bS4Kt1JY8jq5g+pHUhJLmbrLHyLqqfH+ky1ExaclwYMCo9eEbFIy76LltT35HkOYen7hgYrTSOJ
	oqGDvSuiVks+U6+rgCzbLz8O5xyxpXO9QglgHftKOsQSy68KaEQfyq+dmTBZDp+oFO7rWZwTXup
	rKXbLiY8edkP6QgeEhb4WfZuhXkxHZ7oe6bYGJ+J8fKQ8GgO1A4Tr1e6gFZWBjcSd+LO5JoLt2p
	3WDKRLJ3wkx/umwO5FB80pRau7f/ewFzR2sg==
X-Received: by 2002:a05:6214:5a08:b0:894:5d38:2e38 with SMTP id 6a1803df08f44-89c7744cebfmr62010866d6.18.1773937140278;
        Thu, 19 Mar 2026 09:19:00 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b9ce2f2sm56059786d6.32.2026.03.19.09.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 09:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 12:18:58 -0400
Message-Id: <DH6W8F4R7DD1.2P3M0PKI1V5BM@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 0/8] bpf: Extend the bpf_list family of APIs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Chengkaitao" <pilgrimtao@gmail.com>, <martin.lau@linux.dev>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
 <haoluo@google.com>, <jolsa@kernel.org>, <shuah@kernel.org>,
 <chengkaitao@kylinos.cn>, <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260316112843.78657-1-pilgrimtao@gmail.com>
In-Reply-To: <20260316112843.78657-1-pilgrimtao@gmail.com>

On Mon Mar 16, 2026 at 7:28 AM EDT, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> In BPF, a list can only be used to implement a stack structure.
> Due to an incomplete API set, only FIFO or LIFO operations are
> supported. The patches enhance the BPF list API, making it more
> list-like.
>
> Five new kfuncs have been added:
> bpf_list_del: remove a node from the list
> bpf_list_add_impl: insert a node after a given list node
> bpf_list_is_first: check if a node is the first in the list
> bpf_list_is_last: check if a node is the last in the list
> bpf_list_empty: check if the list is empty
>
> refactor kfunc checks to table-driven approach, and add test cases for
> the aforementioned kfuncs.
>

By the way,=20
https://sashiko.dev/#/message/20260316112843.78657-1-pilgrimtao%40gmail.com
has some additional feedback apart from those of the list bot.

> Changes in v8:
> - Use [patch v7 5/5] as the start of the patch series
> - Introduce double pointer prev_ptr in __bpf_list_del
> - Extract refactored __bpf_list_del/add into separate patches
> - Allow bpf_list_front/back result as the prev argument of bpf_list_add
> - Split test cases
>
> Changes in v7:
> - Replace bpf_list_node_is_edge with bpf_list_is_first/is_last
> - Reimplement __bpf_list_del and __bpf_list_add
> - Simplify test cases
>
> Changes in v6:
> - Merge [patch v5 (2,4,6)/6] into [patch v6 4/5]
> - If list_head was 0-initialized, init it
> - refactor kfunc checks to table-driven approach
>
> Changes in v5:
> - Fix bpf_obj leak on bpf_list_add_impl error
>
> Changes in v4:
> - [patch v3 1/6] Revert to version v1
> - Change the parameters of bpf_list_add_impl to (head, new, prev, ...)
>
> Changes in v3:
> - Add a new lock_rec member to struct bpf_reference_state for lock
>   holding detection.
> - Add test cases to verify that the verifier correctly restricts calls
>   to bpf_list_del when the spin_lock is not held.
>
> Changes in v2:
> - Remove the head parameter from bpf_list_del
> - Add bpf_list_add/is_first/is_last/empty to API and test cases
>
> Link to v7:
> https://lore.kernel.org/all/20260308134614.29711-1-pilgrimtao@gmail.com/
>
> Link to v6:
> https://lore.kernel.org/all/20260304143459.78059-1-pilgrimtao@gmail.com/
>
> Link to v5:
> https://lore.kernel.org/all/20260304031606.43884-1-pilgrimtao@gmail.com/
>
> Link to v4:
> https://lore.kernel.org/all/20260303135219.33726-1-pilgrimtao@gmail.com/
>
> Link to v3:
> https://lore.kernel.org/all/20260302124028.82420-1-pilgrimtao@gmail.com/
>
> Link to v2:
> https://lore.kernel.org/all/20260225092651.94689-1-pilgrimtao@gmail.com/
>
> Link to v1:
> https://lore.kernel.org/all/20260209025250.55750-1-pilgrimtao@gmail.com/
>
> Kaitao Cheng (8):
>   bpf: refactor kfunc checks using table-driven approach in verifier
>   bpf: refactor __bpf_list_del to take list node pointer
>   bpf: Introduce the bpf_list_del kfunc.
>   bpf: refactor __bpf_list_add to take insertion point via **prev_ptr
>   bpf: Add bpf_list_add_impl to insert node after a given list node
>   bpf: allow bpf_list_front/back result as the prev argument of
>     bpf_list_add_impl
>   bpf: add bpf_list_is_first/last/empty kfuncs
>   selftests/bpf: Add test cases for
>     bpf_list_del/add/is_first/is_last/empty
>
>  kernel/bpf/helpers.c                          | 121 +++++--
>  kernel/bpf/verifier.c                         | 116 +++++--
>  .../testing/selftests/bpf/bpf_experimental.h  |  16 +
>  .../selftests/bpf/progs/refcounted_kptr.c     | 311 ++++++++++++++++++
>  4 files changed, 519 insertions(+), 45 deletions(-)

