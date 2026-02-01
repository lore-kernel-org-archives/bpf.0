Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD61EA7F4
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769963660; cv=pass; b=D347poJtnmt8EqjVm66rpCI52/E1VYzBeRnAxnGfWtTAV7WrFOfBC82CRvBBheBV/wqydAxfCCyTZL0rCnOjBjDBrDnVa91ROA3Z1XkD3uFwf1gAcClo22/ZY+qQxlKrVTZAR6kJB9WHx5VSfPsot6mGUwxjlAeau3rWiVJDDco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769963660; c=relaxed/simple;
	bh=9vARzbqm57tHwuhXaOkV/GDbi+y1/yz3tQ/mR3mTHg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jw1KI46vDL1Tnw/oQ3Pdj8uEJFeOhBQNYEan1QvvsVedix60YXEKLIYnZ0epJBtzu0kvLWdhSnXR0/uPDTWZHOQI5f1gJel+UJ3jGhIvYLnveaqJbKwZQvcrW9NTTeDuqfov4gNmAdDTeysHxxInB8Ut8eJLsXucwlKf35qqHfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH26GhD1; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH26GhD1"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so38437465e9.1
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 08:34:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769963657; cv=none;
        d=google.com; s=arc-20240605;
        b=IEGfdNiu50QQoOZyGHEx5VazsKwwGOjyB5v8jJv1M3e2u/AwfDrP1j0uCGh0bNy7ro
         PnQRjYXvolltWWvAULuRyWoYI6Nhn2asUMfjNis6uRXtdcr0Eq4iL4ObC3FRbC4GoW1a
         rR8HJekdVp5mluZWPW+cWpRRiDcPSztq4zPBKaszFVvugpP5reIMaoYcnJCkNB+yEMA9
         LkWjR/dbWiuOlwqEErYyOqScjgxsnqa0DUfgu3B7DJwPhdpLDrDqaq55h2a7dZr3Rhh5
         gMFxSHE3zL+u4omNZ2y6SWUgSIQdrEAR8+Bq4svArXqo4I7zk8wFdPmIY4fA1G+BqR2Q
         NMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u0Iy9aGR9ZHnPoAbdsA1GkEXv4tNmEq2SPJm+D/xhwc=;
        fh=qyQ0aRNZEwQoAyW0zJk4MfnOBbCF5wxwkmXD36qAbqY=;
        b=TzpbvrOJrAyqJ1fCiHgFQ1be5a6zcfGmLuaXada/Ci3c2P8Wap+v/JeIKr13+LB/3R
         rLQ89kmTU0zOaNGy30pHKW7Gz3RE/dC3z246lHhkg9SvX2+bBNPU42JQbLPtltfrIFr6
         TNRP8KJ4h2QH7TZaOxZn/hEtUFx0kjySnGYkvqeCybJqGle9/Nr4D5Z3cDHFAkxlUOdG
         VtqgAPJhEclTvhshJdXOxIBR80/IybSwrVPuLsRqDriA21ZJj4R4XPHdyXzpelEbSIBj
         6HBCCMWPn2S7Pr/0WuwDjQJiJNrZVSCqgmkJVxhbs2B8ibwwvjPbl9f8K9f12FTxpqLw
         9cxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769963657; x=1770568457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0Iy9aGR9ZHnPoAbdsA1GkEXv4tNmEq2SPJm+D/xhwc=;
        b=SH26GhD17Mc7LRD0W+pRH9GdbyywkcdDLfjEN25lZoyNq9U6dvEo4bjQ8OmURHNqf9
         kY/ECSITSwhbJpZ0sXoqhTRqW0bZnjAn8ISaxq8ZUK4s1SxJl8yhMXN3iq6Dw2xR9wWc
         KXwSaGHHQ2Ns4f7Lfkot2UUj9sO5PgOatIZxwekgfN/EiirYA8q6QobfPReQ8j0HJqKJ
         TOGK2bSJyNy3zKgrW76lnp1h4BvG728gyAHHtZyBppuSDX0eNMwd8L53g8BNgr1D1L34
         65rVzTJmR3WiAsBI6MNcnHKEMMirVe309IihVm5VD49wtNmRTZxSXpQhuWbGt3OvgqyU
         jJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769963657; x=1770568457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0Iy9aGR9ZHnPoAbdsA1GkEXv4tNmEq2SPJm+D/xhwc=;
        b=S/FW7/PA4UY9uCTb2jynGijoeDCWDmamngLUIDRjIUC6pk3VTrHNKG9UjRck5oc862
         a4mdxUKO4M6EJKEdZhVJezQsx6QukEL5K4mZyLY3FJxult7dU2QU5hfQrmNFEre6sqK4
         b8/qwQYRycZur9GyttO0AFvpEbu//MMZXkbJQEZGK8QMGFE5KZxE17KBK34pjGjQhKVv
         nnsXAeFuWfL6UKbYcwlLxs0YRhfkO+P6Xg12gSInHi9JSHfk35AsFuWn5Cs8R3Jxx0Ye
         tKxabimwkW4IcOocYqhbJK4PIy5IY9pDwRIwVvUvg5lKasozzrl90W87vsQzRTzu7OSx
         Jd3w==
X-Forwarded-Encrypted: i=1; AJvYcCX+E1VRNBAL4C74EgeCa12Aq30nvbPIkQQcpCc2CTq2XQliScI8VmjdDumGuJt4PWz2cHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUCNcmdW5d1nmZv6QzEfOmv7LaD0xegv/txPQ3K8TKOsjgGS8U
	cM4Quns8xiPaGJ5iL3DnaQ5WJ0e/Q97X7QTY7Qe4q5zku5DrXL1DBssdtov0+LrL8N82w787f+J
	uSo8enEMYGxg+UGHaye0VXdfPlCN6YpQ=
X-Gm-Gg: AZuq6aLdDBJqV4fg/Z/8zNaH8Jecwgk0giFtqCl2y/vvn1Qa9OL8gDmvtoW1Zx0//Dq
	7khCHZsLxqTnzAC0epOWXxn4pUEZOlBQxaUsoCzRQrXHJALavjEnDZJ/wf9JF2LFHC7S+8weR/f
	CyI7XrYu55sDKaeqnzA4ksvS6Ph/ea4oOy1DTmZiVepnkhoC9wV5TYp6ZVrLAcxIMinjq6vMDk4
	zUFE3440CZf9OAVdH8eJtX+ObV8xIWxe4+g/DweaTa3MbnK1o8Tk5pupFWyZVpLLUXwTcxMCMA4
	RL4BY+JJWlfCs2E+PDPkY/TdZ1PbAdaQTNnY2cf5Z+PnBp+NJuulwFTwueVTNIEsKdZdhaQLPFK
	ZhEJSMpvQ1HWtkiiihN7IxM/a
X-Received: by 2002:a05:600c:4e12:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-482db481c85mr120406455e9.22.1769963656749; Sun, 01 Feb 2026
 08:34:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201031607.32940-1-pilgrimtao@gmail.com> <20260201031607.32940-4-pilgrimtao@gmail.com>
In-Reply-To: <20260201031607.32940-4-pilgrimtao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 1 Feb 2026 08:34:05 -0800
X-Gm-Features: AZwV_Qhcz2_dwtnHN0abQtq47NxLW3mB88GNnOnp3aBl9Ob11U6ru31evgMuNbs
Message-ID: <CAADnVQLFBJ5BKv_6UBk7Wrv=-5QxZfG=856uj+rUKRDcxGWbhQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftests/bpf: Add supplementary tests for bpf_kptr_xchg
To: chengkaitao <pilgrimtao@gmail.com>
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

On Sat, Jan 31, 2026 at 7:16=E2=80=AFPM chengkaitao <pilgrimtao@gmail.com> =
wrote:
>
> From: Chengkaitao <chengkaitao@kylinos.cn>
>
> 1. Allow using bpf_kptr_xchg under lock-held context.
> 2. The rb_node contains a __kptr pointer, eliminating the need to
>    perform the remove-read-readd operation sequence.

typo

> This patch implements the following workflow:
> 1. Construct a rbtree with 16 elements.
> 2. Traverse the rbtree, locate the kptr pointer in the target node,
>    and read the content pointed to by the pointer.
> 3. Remove all nodes from the rbtree.
>
> Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>

Please use your full name. Like Feng did :

> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

..

> +#define private(name) (SEC(".data." #name) __hidden __aligned(8))
> +
> +private(A) struct bpf_rb_root root __contains(tree_node, node);
> +private(A) struct bpf_spin_lock lock;

It doesn't even build :(

progs/rbtree_search_kptr.c:23:1: error: expected parameter declarator
23 | private(A) struct bpf_rb_root root __contains(tree_node, node);
| ^

pw-bot: cr
