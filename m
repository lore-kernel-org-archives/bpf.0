Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BCD273D76
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775183208; cv=pass; b=pTXvr0Ft81SCcgkj0pWNVvgcH4xRQ/EDMhT7iYDnQHxzrw5XK4+KZqUUxjK6utU4/+NJgfNbgLoYjWPIYJXlfCNL0050oMT3bSdYzAGvqEC0rN20Hvw8tJ4uJoYgoIp0jsv3xk89WI8jhuy16bSNYprFTQRdvy18x5cf/UcdCvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775183208; c=relaxed/simple;
	bh=vcJVYVcsjtujJhxPM2Hmf6GUicBFUB6Kawjcdbn0m+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlvWBwNXuNxsiJYcYu0+LYUoiqI2IfT+//hDj0JZpekoWZ8A9XKTzYQiQWY7MKB76Q9TN97uu/coZZvqSfp2nsompxtlPZrrZODeDOzAlfA7Qh/qAZXWuwKcZyLL8fuJKZx2IlfgsGOYVNdOfQa1X1QzaKvMrdB2Ub6oGXXZ7Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pj9APJiX; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pj9APJiX"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7986e0553bdso15329467b3.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775183206; cv=none;
        d=google.com; s=arc-20240605;
        b=X09F++dKkFZyW15RbiEwn3LkcscHiwjmulU/YEjz6yKjUXW2jPHiyskUpW0gaYJ+oz
         m08BQ2alVmjXlXCL1EYLeZptnovLw9gjUsWj/o4eOMLWsPmzLoGyZSyWlHcN2/Gdcw8f
         VZAouXgknHOHA/FuUd6DBCdh0HsryigGNRq/0u4+b2azGryTFrrWVFyqzbREwMPn8Q+Z
         HEcDLFYQgwG1bZWslNnF9sdusDpIAKCQaKxpfZ05XlbKHK4/NZFieDf1UbJJrNgGt3cu
         6rX20RGDYESIPkS1WLcmTNDzbZ0ODk25Wj31H7gKruqQdPKUQE0lF2slgA6xYrh08tBM
         E/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oDMKzHqeL/XyiO2Bewz0UeWrM+1zjaTUFq6LPDrd+SI=;
        fh=MWJYJFxuQxxF2xd9iFemopavTXOaIU/6hnyvFFBUqIw=;
        b=eBf73x2AfN19mOiM8crZJTAJ73l7h6X5iSRHNwhtvzaka5UpBT1dXocMKHx8okEV0k
         WxxhO7VPns4hWN/90m+prIyXg4zEpvg1Yy4kVdyrLnHQ3FORTeC8BCGeo/ZRttIQUxZN
         met4gJoqUE8PYPQhCRB6g+xcFTqU5MgZ2InXHvKs3MPrHRK1MvyGSN1vn9nR/+cWX+OE
         eryikDcg8dgSjBCU/i7m27IK4PdgLUYfyIZFA3rEZpyElyetSa6qCE9VLBySSiJdX65b
         dN4yTDHo63XNLOPXei7pR7tBQEFRBabVdePeLwyoSXJprKBPH5iBG6yd8DXvuLVp1/WI
         PDnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775183206; x=1775788006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDMKzHqeL/XyiO2Bewz0UeWrM+1zjaTUFq6LPDrd+SI=;
        b=pj9APJiXwPQpv2w/t6G6RTFnZEOcQthmzNUT0gh9/PMgPwKu0cOD8de4u4xK8MFJG8
         rh5op5ZoOQFvio0wkCcf4oeMdLGXICbgT0ECbrVKn9uZwhLNNVYPQwgL24ik/wPbdw/n
         u5KFOb+Tuizym1/1P+Di0L2Wwr5/HOANx9ZcMLCy5hDIEkFgBImB8ZQjW4sw1rsUWTh+
         ByWNE7yg5BohdHOxBKMA0nSisf1YKIzKOw0bKPmn6LqpQctIK5vy7s2NhKCslkRlkNEY
         zv+sYPBO1mzQuJNfw9rfaEIuFv6AuqLwyelA3QR4mlS0VGVbYGY9eIxKBaE6y/k5acem
         nkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775183206; x=1775788006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDMKzHqeL/XyiO2Bewz0UeWrM+1zjaTUFq6LPDrd+SI=;
        b=ECTtVzkfLfsvH+o6DeJIROfjSuJ6ohnBq7rEyVcKXI2y+VF3hj45eM0LDdsz49xiT1
         IqkEyWF4NtKLq451/jRpHYtApSCbBugjMe9BCst9SxCl37hZYTdcMnqsoACyws7C1mbx
         Tr2pCzUpA7LrCxap0xJzdg7TChQ8aPDLL61ijJsvGVlvvSx+FpmAb60Y6w7R5ji0PNPn
         yA7cui5VxkNHm8OI/RzsYJtH+GOBURKBcOS9IeelOt9+jt9WtXvMP4SbAXnRbvSlYv45
         9iwwP09SzoL8YT+A8DeHNtSW8Wm5CIdwxNOW6XXYi//JDVXkAll/9gcjTFkNbQ9+x7dX
         qN8w==
X-Gm-Message-State: AOJu0YzazftAxRoILhNa5asucULmH/t4NHEkP1tJy+OxyeEzBe8HyO/Y
	iMugS5+yBYRNKqpjti4A3Rp/mZM8SKkwZSRUVojX9gDR4jZkpMqJWy3bMLNSb/1I3kXqbx4VMGN
	AlSLtHjcjP9lClLOkvwxjTbKKS1CbzDDQA+LCRui7SQRPD4XhRl0ZbT8B
X-Gm-Gg: AeBDiesgHmVYIrKdg0sQnB8jGaBPgSPVb8iZ9CFm96yQTUGLQS8FBMonTuPDhNPFUis
	7Oi2YokhYGJZg+DRLmksCEj5wCsXT5cbQhyCnZgvJAUFk1L7Fo5WdCObmFO80ew5N2Ei5f6JSzs
	SZu5/eWQASvY07FY2ummVooMWA9rV8JTWI6QSg1qe7ccua5BJNoeza6gjsYG/9G0r8qZHanIWwb
	vjs5z3nl9QbOPCOy0i8O0bHjRSE2R1kM6CPcOSrCbgpSSjTZgtq4bb/Tjf0pIymGRSSWnukX0UR
	AAzlhYtrZOhazycG8A==
X-Received: by 2002:a05:690c:90:b0:79a:c396:c01 with SMTP id
 00721157ae682-7a4d6732758mr17280927b3.55.1775183206003; Thu, 02 Apr 2026
 19:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403015851.148209-1-jiayuan.chen@linux.dev> <20260403015851.148209-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260403015851.148209-2-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Apr 2026 19:26:34 -0700
X-Gm-Features: AQROBzAh2Ysi0SF15X8q_e3XfU4X2ZmmJIBBcIrVoyrG5eWnijGl8DAlrd1gYkE
Message-ID: <CANn89i+1VzG3KSv1NvhTbPm2EdG4Lvii256yZj_wq9jcB-qQ0A@mail.gmail.com>
Subject: Re: [PATCH bpf v6 1/2] bpf: tcp: Reject non-TCP skb in bpf_sk_assign_tcp_reqsk()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 6:59=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> bpf_sk_assign_tcp_reqsk() only validates skb->protocol (L3) but does not
> check the L4 protocol in the IP header. A BPF program can call this kfunc
> on a UDP skb with a valid TCP listener socket, which will succeed and
> attach a TCP reqsk to the UDP skb.
>
> When the UDP skb enters the UDP receive path, skb_steal_sock() returns
> the TCP listener from the reqsk. The UDP code then passes this TCP socket
> to udp_unicast_rcv_skb() -> __udp_enqueue_schedule_skb(), which casts
> it to udp_sock and accesses UDP-specific fields at invalid offsets,
> causing a null pointer dereference and kernel panic:
>
>   BUG: KASAN: null-ptr-deref in __udp_enqueue_schedule_skb+0x19d/0x1df0
>   Read of size 4 at addr 0000000000000008 by task test_progs/537


>
> Fix this by checking the IP header's protocol field in
> bpf_sk_assign_tcp_reqsk() and rejecting non-TCP skbs with -EINVAL.
>
> Note that for IPv6, the nexthdr check does not walk extension headers.
> This is uncommon for TCP SYN packets in practice, and keeping it simple
> was agreed upon by Kuniyuki Iwashima.
>
> Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>
