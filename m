Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACFD280035
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772776079; cv=pass; b=YUW69cQtRq+Zvk5G7ElRtDF7zfPkVQsRkOdGP7bRO1bqDIO4oR5wVEAtOaUJuHWMQnSp1U/blAvJjVyQvHqtH4+HbgLQI7/N+iJeFd5YZrAs0s1mbM8+MMjxdCO2DKaQpjCHWy5EDc7/vQ4B9Ne69qib1b3vj2hukAU/jLypmpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772776079; c=relaxed/simple;
	bh=FWoKnzFkU1fho+/6SGBYDFjVkFjVU4+0P4fHA5HMTy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIaYjgJbKvc+C31li8xSDx91EoBnXCVnXumcM7h6+pWhJgGfm66C2Jtx/yCVs2XIjy9VaviBSw1fhse2cfQ/83Lvl7TGbPB1EjKJVOcGylM7nFmNDE0SK05PP4/KXqBDeJnZdbNLbWymNdF2ANZjCVHxhFwSH4Hilf+rWRhbnxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2v0e1a9J; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2v0e1a9J"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1279eced0b9so7600195c88.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 21:47:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772776077; cv=none;
        d=google.com; s=arc-20240605;
        b=jxb4Z6hhhQW+XerXB98c4ly51J/QsBVrU3xqB+j+4Nj58kCp20mip/KMfapVneZaS3
         R3ce0jmKhKBRnEckAs0NINjzdurbifbJ/Lx6kAkMWDGNbD/wPw2X4cmy1CCO5XSV1GeP
         42PHrcQtkhJVRWecooGkSKfxL8c8mU36KDp0+Sw3OHTH/Fvx9hEvhe6URjdOx6AgXGY1
         P5DE6jgyWwknWyt4UvIgPtg8BnCyqEFNI1HoLdGU9M3VPKjPm8nVBO4D8qP7KVsA85Bo
         3UPQdQQFzh2ZBdfBBERzZGo+KtA+mv6X8hrpioqE3Aj+RQawEYaTpq9fu7m9GXkaI+sY
         k5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gpXO7mHlaGT+SvMmByXwqY9ET8QOSb7XZwHnLOlPXCw=;
        fh=BA8oXlKWReBiJHOJSSx6EmmOg91HB+HOrIKvM4XjItE=;
        b=g9w9qFLRKh8jWinHgxGHyO78T5DbaJ/dDRt36PxljFCey2NN982ZPUoVIb+zDX+HT2
         ziLiYVefAh/EMFCi8mRiZ2XxyBtNIFEqaAmKNv+UwuaNdiUOBQbg9rbbHJGvnYI7wpsW
         4L/WUZhVzh6zvuIbocOxdGlvA5ateT8KG349aXb8IDdmidO6vhyUm0NZosgLRqRDunbW
         zTUcJiRIWK121nPsSheIuDiGwq2aGvA7K8vpV9vu5VQVaSgqiqGwZ012dKRu5yByaLJ7
         IImnHcCyIX80Je5P+7o0HxqXO/gFqSCylPm59HprHvszomyKHyfHUUtl721StMPopEmq
         nyWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772776077; x=1773380877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpXO7mHlaGT+SvMmByXwqY9ET8QOSb7XZwHnLOlPXCw=;
        b=2v0e1a9JEOR8zNQUmfjtW3wi0m/G4WxMvKR7bat+cH/6HNE8pdFJdKITXphSCUbn91
         5Tgmf5g+6xeOw4ORMP9qvbw/rbc03dmet6xTn3HPz5356yS/uaVgIDGgiKyFD5Sy9rTs
         tY/U4AXi78fY2aeA8if9lSQsVjD+Mx0WOaPtrS/lrTj0nIMqrUJUEag+suicHin2fOKZ
         kmjC7RokPiEliw1CBdp8xyXj7lHoG/OpcNsPeKZC5e73qxDKPkTN6sddRxRzLlTmfFXc
         ZeQIJ5WMVJlYj/w/h4ObZRdRJNwjMEt26dfJOhPQ/Z2G5AYFT6blJgYtxiNyLKLZA8il
         fvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772776077; x=1773380877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gpXO7mHlaGT+SvMmByXwqY9ET8QOSb7XZwHnLOlPXCw=;
        b=KdO4h+TeDqIqUbj0c3abIQffoAAsisJDHeVJMn2vZWFqWoJwnXFzkuAT+hUylzEogr
         l8TdTCCS0aQjwam55WkNzKZg/9rjPud6QqQhynvGTIlwTfyboBmjtCXd6y2uUdDaKeI8
         HtLwVKQpRABV5QDeMobi9oqSVAwkF3fVd0GkZzJwNLxYtROO3lBnoIvLGT1GJQaILBkY
         EmXqyTHG2DmWwSLNlWE4aDS8S8gIq4X2PjdZIolpAt3WS2YFv++GeUixPAbfFNRk1F/l
         h9vSV1uhv6SeoeEYf/9hX3zfwnZylmUV2nq97bwPjIqbol9sMzYSr/yjaS183TQ8ja7R
         mVNA==
X-Forwarded-Encrypted: i=1; AJvYcCVD38gQLrzZxmF6g0BRtSw01fx/6QXx9z//ntZb83khoKiyjYrAiwl9J4z1Qr2dtVkDFCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0SMWWlp+b4uvtd6ue12/y3dLn0rlN0VXF3m/rTMyyWNSL/Jy
	3XONCoYs6dd61/Txjo7Z1zPtDOBxtaPFG0Z7TIhi9oYun8PpV+C+yPT01xcSYEQxLEQFhqblv3i
	O3IIdMqswLHeV8Ks5XEQ77RT7wXWWihvYhvtVQ/x2
X-Gm-Gg: ATEYQzw7BjdXFu/EdJCkQay2UQ9qbrmL9wOaKBUETpBq/aQgvyhZB87AI7i3BR0pXg0
	wHZdUE7SyVgXN73vnY99WLML3pwlI/m5XXnHLPP95/qbAA25BzqwoyN5lEOUbDAwSeLBBRexbLD
	peJ36ekP308L0kMV4hL4S1fm10KjwmuIMcsi1crDvXeEn/79V8x86vvuenWQcpeTjUTEn9HI8BE
	oC8mYO8RO3yXD4GJ0MOD6Lu5M9Lc+aolgd8Pc83HTDHbyDbwshlaAKVjsFEyWNW8SOZ3/2ZrtRc
	gYY1j1akEiWXzjfdcQi3gh9oQNS1iEcTL2fOk4VK7jWkmTxsutKNUdqvrKeA7TWPMGrNzgFBAGh
	Nqt4hSik=
X-Received: by 2002:a05:7022:117:b0:119:e56b:91ec with SMTP id
 a92af1059eb24-128c2e8b925mr401820c88.29.1772776076587; Thu, 05 Mar 2026
 21:47:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-3-2f0c7410c523@rbox.co>
In-Reply-To: <20260306-unix-proto-update-null-ptr-deref-v3-3-2f0c7410c523@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Mar 2026 21:47:43 -0800
X-Gm-Features: AaiRm51rtVtTlMmtHwM6HAI4yCYAH4c9qJkSJtwY41_Op2u8ii9foodM1xMuJa8
Message-ID: <CAAVpQUAdOCM1h-G-vU+tdEdOqc5+YoHypKwV_w5m4bAA4Ai8Yw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/5] bpf, sockmap: Fix af_unix iter deadlock
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 3:32=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> bpf_iter_unix_seq_show() may deadlock when lock_sock_fast() takes the fas=
t
> path and the iter prog attempts to update a sockmap. Which ends up spinni=
ng
> at sock_map_update_elem()'s bh_lock_sock():
>
> WARNING: possible recursive locking detected
> test_progs/1393 is trying to acquire lock:
> ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: sock_map_update_elem+0x=
db/0x1f0
>
> but task is already holding lock:
> ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: __lock_sock_fast+0x37/0=
xe0
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(slock-AF_UNIX);
>   lock(slock-AF_UNIX);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 4 locks held by test_progs/1393:
>  #0: ffff88814b59c790 (&p->lock){+.+.}-{4:4}, at: bpf_seq_read+0x59/0x10d=
0
>  #1: ffff88811ec25fd8 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: bpf_seq_read+0x4=
2c/0x10d0
>  #2: ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: __lock_sock_fast+0=
x37/0xe0
>  #3: ffffffff85a6a7c0 (rcu_read_lock){....}-{1:3}, at: bpf_iter_run_prog+=
0x51d/0xb00
>
> Call Trace:
>  dump_stack_lvl+0x5d/0x80
>  print_deadlock_bug.cold+0xc0/0xce
>  __lock_acquire+0x130f/0x2590
>  lock_acquire+0x14e/0x2b0
>  _raw_spin_lock+0x30/0x40
>  sock_map_update_elem+0xdb/0x1f0
>  bpf_prog_2d0075e5d9b721cd_dump_unix+0x55/0x4f4
>  bpf_iter_run_prog+0x5b9/0xb00
>  bpf_iter_unix_seq_show+0x1f7/0x2e0
>  bpf_seq_read+0x42c/0x10d0
>  vfs_read+0x171/0xb20
>  ksys_read+0xff/0x200
>  do_syscall_64+0x6b/0x3a0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Fixes: 2c860a43dd77 ("bpf: af_unix: Implement BPF iterator for UNIX domai=
n socket.")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
