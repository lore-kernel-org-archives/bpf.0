Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60065B21A
	for <bpf@vger.kernel.org>; Sat,  7 Feb 2026 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770501647; cv=pass; b=KE3AWL6be3BL18LNxgM/eTEJm0E5fdEboFX4ZGq/k4V9s5aNl13N/LUWeUpqjisGzbEcH+FmLn+414HvzIXrXo63VALSguev9yh+W6E8bbEDV5WNsjtBU2KE8yyBC2nrU8hqOsaPVsuiUzAro81rtbR2zJoKPix79AAweWOkDAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770501647; c=relaxed/simple;
	bh=JDXfqM338ohvB1O9rA0vcFQqdt+sfLaxVbYRueQmL8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y09gkZcRK3Z8bwkjMQxAH43SiYmsndMlS1ui/m8GQatturj2aNYFfH1V49qQV4RQpg8AjPgjtqfwPdhoqGSLzD8+1EzNetVXxU5RJbOcMLp4GLuF5CB7Zq61xnWdJxzOZ7hHfDX8wMV9LDxwzqFjuzwMNoCVGxqy8cLFQQTNcHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=diBcCVa4; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="diBcCVa4"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12713e56abdso219393c88.1
        for <bpf@vger.kernel.org>; Sat, 07 Feb 2026 14:00:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770501646; cv=none;
        d=google.com; s=arc-20240605;
        b=dVBAcfS15NcwJSFwDQTAPYabM+Cj54/42WvuM7yV4aFbOa0Kvqeha2ZWV/4D/5DHUi
         Pxh5Rf1TyU40mbfwcGBpsL9cMJPdrJ1qt9yWDibiruWpjlzYos8x4bQqox+FNg078Fxl
         h1Xz/lWUIIkT12y4O15JdpiRQwrQZAA8+Or7rRB4hcih9iPScMaV3zqbyKpmWRAamO8Z
         mKYibVSVOyJal+gowmVJkzkixsYf7uT4WbCL8G/8JAzD2aaPoSD+t/dNDPMa8chq7tv+
         1HpEugSHOpSjSygHhRFmKTLUx/pk7xuZXtdtEU8kHeqnKQ/98Ks/s+u2rCZvsEAhrBhm
         7TLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1lbuS73M4nRAMSUMQkgHo/xlGfKNIQW3qCJPmnbJ+uc=;
        fh=kN8zYZp9Q+B6SNEZAHd7j+yS42F7uCjTFM57wFG4rSU=;
        b=FRn4I1fp4UCoqckqEQihImi5zpWUlSZPUqkvqWwhcGPGi0224SdNGblShRW+zKxP39
         LmrAFgKVhZX0DY9IE8+eZhxmOOPe3CK+BdAR8I6fHM1e6/7gK7vlM97/WNVyC7jtQA3o
         dgUzdnTKBf7XxPkBiddtU4yfGhysqioueh/Hw7A6rAIjGohzaO02H7QeERs33IyXHdq4
         Crjd8iRSY9de90GGjDlHINHirmtfvTAWFvIzi6+sT2jaX4SpFux/6Ek3rZzc9g0EeYsI
         e9n/4KFMyQQRV8g6n4OkhGaqYYDRr5n8XBeoZNQXfn1hP7r+iLAK8Imm3F1ewLir80NR
         qXiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770501646; x=1771106446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lbuS73M4nRAMSUMQkgHo/xlGfKNIQW3qCJPmnbJ+uc=;
        b=diBcCVa42dcqTlGFWSsbHkJ9QMaFFXxrX7rOhCie5vMTNI34f+ep0IPPwYbXS+EEFc
         xuoCrRdR8R3tCy9p/vpBWKj2matoRcNU+9acpvUKmwaHGR25U3Tpg3eRoMx9frD+tuTh
         errHgwlKwsX998yrVFV45whsLwRqitDyFeGNNlxPhCOeqPSJHiGfw5KvSqBKnvH6lp++
         HXz5kbmWxQnaBDRltiGKQjBz243n1AxwUNkLxwJM2n6R/xcem7jCuowilHH/5YO/s4OZ
         30OJTyBTASwqSEg4His8Vx9j1Bb5O3VoVyXZXx6TdVU+2v1mvVv3SixCk1T29NVHN9Wd
         onFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770501646; x=1771106446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1lbuS73M4nRAMSUMQkgHo/xlGfKNIQW3qCJPmnbJ+uc=;
        b=dUdzAgJtIZsxUMiNEf+0JJUfjyn4yo1DGJsymciJ0vVEKytC58p05Ns856QX37JyON
         2e2ilMtE8veld6ECCKwGtaN9ZwDWo3WBGzWlalTpCm41LuNuyNLwOM9erEEMSRrwSynu
         SxNLlB5FetsPi4GyFInCJERJfjo+235H8PjYRSSW1QllnpesSlkzPZ48JtbYjyfviCkb
         Tkb4NuMd8toYiTzjruDW0aZokabT0D9iAaQ4gxPm3oxfypclfRF23eQCQt4ZcFAzTehe
         aHbGyIsd7eMkBkdb4Ow1Z80ppUTEA0wXyN8/DZC9fn6As8yvRS/txO1kYUyR3UAJp/MF
         O23g==
X-Forwarded-Encrypted: i=1; AJvYcCWpwwtyd2dOjEINUUdLFBYItK1G1ddQiZxBv3xbh9LBNgX84Q93x4PH7KkNPhv1sZ4uMis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1PZJBdR81NU+n6YEacAKQf2WFDdWRM6qb2WRceLSwgSGa9h87
	eVuCi90o4I2QbigCfYMH6X1OOr2I4JK28UdTsiPyT8ecCtyYg1iDsLPI5kg772MFmD+7FXJx4wJ
	KkdylWBWmOBSgDRAhAzY0mpxBv2o/yEUQf4Lr+zUO
X-Gm-Gg: AZuq6aIng7PVmbMSAmgY9SL9lhcdPClos7CH41sUA+r7Y6cwk7Xc6HmUxnLmVEYq79A
	Ve7dAwKwbKOikyJWGJCBrwNJYlMO47XnvrKx+uQIxMmYCyg5SFTFyfBgeMWgaICubCMdLM9Q15s
	gCGJAVO9nf6TtN1XfycocCksJOyBNZih7AcmZd2c3N09emrRFUb+YbhdOUpgk3i1cPsm7p5rInF
	A6ORKjr3jhcjRvNMAqHfstKBs0xTRtcF5U6gGscyMqToqKDpieTfR+ueFOAeL14xstnxMgK2Rnb
	N6mYuuD3dbS1haxAZv/hx/hPF8vIxBWkfq6EE9BLaixZXiwPhVWKDaBklqDp
X-Received: by 2002:a05:7022:6894:b0:119:e569:f865 with SMTP id
 a92af1059eb24-12703f17080mr3211761c88.2.1770501645337; Sat, 07 Feb 2026
 14:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207-unix-proto-update-null-ptr-deref-v2-0-9f091330e7cd@rbox.co>
 <20260207-unix-proto-update-null-ptr-deref-v2-3-9f091330e7cd@rbox.co>
In-Reply-To: <20260207-unix-proto-update-null-ptr-deref-v2-3-9f091330e7cd@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 7 Feb 2026 14:00:34 -0800
X-Gm-Features: AZwV_Qhu3MPuQb3J9B5R5j7S51Pywg9lHfEECqmBAAcVo3Fs_Cs-5RFQ9cfaiIc
Message-ID: <CAAVpQUA+8GL_j63CaKb8hbxoL21izD58yr1NvhOhU=j+35+3og@mail.gmail.com>
Subject: Re: [PATCH bpf v2 3/4] bpf, sockmap: Adapt for the af_unix-specific lock
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Willem de Bruijn <willemb@google.com>, 
	Cong Wang <cong.wang@bytedance.com>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 6:35=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> unix_stream_connect() sets sk_state (`WRITE_ONCE(sk->sk_state,
> TCP_ESTABLISHED)`) _before_ it assigns a peer (`unix_peer(sk) =3D newsk`)=
.
> sk_state =3D=3D TCP_ESTABLISHED makes sock_map_sk_state_allowed() believe=
 that
> socket is properly set up, which would include having a defined peer. IOW=
,
> there's a window when unix_stream_bpf_update_proto() can be called on
> socket which still has unix_peer(sk) =3D=3D NULL.
>
>           T0 bpf                            T1 connect
>           ------                            ----------
>
>                                 WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)
> sock_map_sk_state_allowed(sk)
> ...
> sk_pair =3D unix_peer(sk)
> sock_hold(sk_pair)
>                                 sock_hold(newsk)
>                                 smp_mb__after_atomic()
>                                 unix_peer(sk) =3D newsk
>
> BUG: kernel NULL pointer dereference, address: 0000000000000080
> RIP: 0010:unix_stream_bpf_update_proto+0xa0/0x1b0
> Call Trace:
>   sock_map_link+0x564/0x8b0
>   sock_map_update_common+0x6e/0x340
>   sock_map_update_elem_sys+0x17d/0x240
>   __sys_bpf+0x26db/0x3250
>   __x64_sys_bpf+0x21/0x30
>   do_syscall_64+0x6b/0x3a0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Initial idea was to move peer assignment _before_ the sk_state update[1],
> but that involved an additional memory barrier, and changing the hot path
> was rejected. Then a check during proto update was considered[2], but a
> follow-up discussion[3] concluded the root cause is sockmap taking a wron=
g
> lock.
>
> Thus, teach sockmap about the af_unix-specific locking: instead of the
> usual lock_sock() involving sock::sk_lock, af_unix protects critical
> sections under unix_state_lock() operating on unix_sock::lock.
>
> [1]: https://lore.kernel.org/netdev/ba5c50aa-1df4-40c2-ab33-a72022c5a32e@=
rbox.co/
> [2]: https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.=
com/
> [3]: https://lore.kernel.org/netdev/7603c0e6-cd5b-452b-b710-73b64bd9de26@=
linux.dev/
>
> This patch also happens to fix a deadlock that may occur when
> bpf_iter_unix_seq_show()'s lock_sock_fast() takes the fast path and the
> iter prog attempts to update a sockmap. Which ends up spinning at
> sock_map_update_elem()'s bh_lock_sock():

Hmm.. this seems to be a more general problem for
bpf iter vs sockmap.  bpf_iter_{tcp,udp}_seq_show() also
hold lock_sock(),  where this patch's solution does not help.
We need to resolve this regardless of socket family.

Also, I feel lock_sock() should be outside of unix_state_lock()
since the former is usually sleepable.  If we used such locking
order in the future, it would trigger ABBA deadlock and we would
have to revisit this problem.



>
> WARNING: possible recursive locking detected
> --------------------------------------------
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
> Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
> Fixes: 2c860a43dd77 ("bpf: af_unix: Implement BPF iterator for UNIX domai=
n socket.")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Keeping sparse annotations in sock_map_sk_{acquire,release}() required so=
me
> hackery I'm not proud of. Is there a better way?
> ---
>  net/core/sock_map.c | 47 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index b6586d9590b7..0c638b1f363a 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -12,6 +12,7 @@
>  #include <linux/list.h>
>  #include <linux/jhash.h>
>  #include <linux/sock_diag.h>
> +#include <net/af_unix.h>
>  #include <net/udp.h>
>
>  struct bpf_stab {
> @@ -115,17 +116,49 @@ int sock_map_prog_detach(const union bpf_attr *attr=
, enum bpf_prog_type ptype)
>  }
>
>  static void sock_map_sk_acquire(struct sock *sk)
> -       __acquires(&sk->sk_lock.slock)
> +       __acquires(sock_or_unix_lock)
>  {
> -       lock_sock(sk);
> +       if (sk_is_unix(sk)) {
> +               unix_state_lock(sk);
> +               __release(sk); /* Silence sparse. */
> +       } else {
> +               lock_sock(sk);
> +       }
> +
>         rcu_read_lock();
>  }
>
>  static void sock_map_sk_release(struct sock *sk)
> -       __releases(&sk->sk_lock.slock)
> +       __releases(sock_or_unix_lock)
>  {
>         rcu_read_unlock();
> -       release_sock(sk);
> +
> +       if (sk_is_unix(sk)) {
> +               unix_state_unlock(sk);
> +               __acquire(sk); /* Silence sparse. */
> +       } else {
> +               release_sock(sk);
> +       }
> +}
> +
> +static inline void sock_map_sk_acquire_fast(struct sock *sk)
> +{
> +       local_bh_disable();
> +
> +       if (sk_is_unix(sk))
> +               unix_state_lock(sk);
> +       else
> +               bh_lock_sock(sk);
> +}
> +
> +static inline void sock_map_sk_release_fast(struct sock *sk)
> +{
> +       if (sk_is_unix(sk))
> +               unix_state_unlock(sk);
> +       else
> +               bh_unlock_sock(sk);
> +
> +       local_bh_enable();
>  }
>
>  static void sock_map_add_link(struct sk_psock *psock,
> @@ -604,16 +637,14 @@ static long sock_map_update_elem(struct bpf_map *ma=
p, void *key,
>         if (!sock_map_sk_is_suitable(sk))
>                 return -EOPNOTSUPP;
>
> -       local_bh_disable();
> -       bh_lock_sock(sk);
> +       sock_map_sk_acquire_fast(sk);
>         if (!sock_map_sk_state_allowed(sk))
>                 ret =3D -EOPNOTSUPP;
>         else if (map->map_type =3D=3D BPF_MAP_TYPE_SOCKMAP)
>                 ret =3D sock_map_update_common(map, *(u32 *)key, sk, flag=
s);
>         else
>                 ret =3D sock_hash_update_common(map, key, sk, flags);
> -       bh_unlock_sock(sk);
> -       local_bh_enable();
> +       sock_map_sk_release_fast(sk);
>         return ret;
>  }
>
>
> --
> 2.52.0
>
