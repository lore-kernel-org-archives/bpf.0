Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794757452;
	b=DWAvC1mj1yq/oXaHTkB1hUmEBpT8XGal75lfyfIlgz1n/udrS12Wzqv2TbRKRHa8Wkwm
	 xgW3ziBJunOtXa81+D+4VJ6etvsE0heFZ8xxGQw/Upey4VndCEJE+na/Po96Z4IEJULPm
	 gHPGD6KaUUkeHSzzYroxVe2oMMNZH/hWMkJGnsbjsdeWpWioRKH+Kr4tD0uoQqM+jZ7ha
	 RK690OeZHI7syGZzQeZZksGwRadxUBGn/6fTQxzvyOTNd+9i5c6JH+xGlOJhMWF/1LuDn
	 VxWgOsTr8ix/+iuD1692bSWEKP7m1VpDdfK3CiTTOQ8FFPgZ7xQarR0m7KT3uSsyMig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794757452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=vUVVF4AJI6A1KyF5MrpgJ8wgNYqK81vISWpwSYQrSjM=;
	b=u0nNfY5/ELOukRdmzeT3KAOTokkYFUKULshr1G47j/bOBmFkolhuZ7v7PnnUd1KkE0Ra
	 u4K5XPG4EVEyrrRkfSbEC+TeU8UvphWQHMEM4uylf88/OzjYEBE2AjwvGUqdLo2RwKIqM
	 jHOh4PQqv6NfxiJkR3Bv5A99QuPJCoPVOGXHamHJ8WW4gu7p0iG2coNUuBNDG/E6rrKOS
	 Nw3jQfeMiIZwywVtDEQewVNeLZFnLfGVUk6FiAxgoNStWtKI4kRSQmQ8Io7Jf37nKf23e
	 dYaArIH8HTiCiFZzbKYSZLS/J0xhti3JNhZ1NzPK4XKxPT4tdDBIDQusjcK3uglsYRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sd6bEbok;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.70
Received: from mail-lr2-f6.google.com (mail-lr2-f6.google.com [74.125.230.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0E606A31A
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 15:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FA0E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sd6bEbok
Received: by mail-lr2-f6.google.com with SMTP id 38308e7fff4ca-3ab1bfd1373so17170381fa.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 07:44:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794757450; cv=none;
        d=google.com; s=arc-20260327;
        b=kc4KJQTif/ea9w1zgy6hQd8mXixz4opJ9GRxvN/jGkJbJizC1iUGkwtPgr2pHh30LZ
         zH6Ry9yxe7OgNPW/N1p8ZCVw/Fqy271fqSHemlEizcD5njt6/e7Xixpy4dAKM7NDvYNx
         NHSk9k7aQ2qgJfwLA6brrReifclujVLLTkeALQ6zqLpG3WLY17w/kpz2jHOZlw0TOO3h
         H6jq2ypteN30KZMzP4kZ2wzYxPnVOuMmJ3oUXOmeExfpWoHlreR/aoT0u174Ke1HiBpY
         gDi2wrQVGq1b1hKsPfxZM8kXv2xqoV2oa2E/UoHbE+zzEkpGhDjTtr1VzCSYkgsPY4XT
         n+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vUVVF4AJI6A1KyF5MrpgJ8wgNYqK81vISWpwSYQrSjM=;
        fh=5YhL2jBGP0Oopjd4pZR9zLgYTfOmEKvjU/sBzvNlSz0=;
        b=ikADSuihpodfYPNezoF8qQlgXiLgvLulXNRPNLEFFRk7ODWGA1Evwm92y6z2muBVe9
         ESFIJ6T74xBRR5Ardk3YXYSw82nNeR8F7i2ZAkHgkvjt0n3JtzYbOvyFYvkAuqveX5Au
         CIb8Sn2awLZnaRQZXDC4NYz7S2KqwmYaRfumz0+rGQ22Kwp2wvM3rdwKT1fYByowYlJE
         qDHe1Cj5almrV46WGXUUGLsilgGg51yY2DsogNgootWl7HaW/jNZ6TRU38OnlkVxXiVo
         AW9A2F10NKQvZZ9YLEacATzg+2xdKaKyp3rDhJmzURIevdsn6hZWoxL/QiFGPWqmq6g6
         xdWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794757450; x=1795362250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vUVVF4AJI6A1KyF5MrpgJ8wgNYqK81vISWpwSYQrSjM=;
        b=sd6bEbokDqmC8HPuZHtMLvJWUEqPx+tuojrCmj9oIEpHkPGG8qWzgd3eDlwowBYEWA
         Nu0yHcrR843BQQCQWsBy6dgy/DILU1+WrzPQ2F0LMSzvwd0mtpjZw9llTZ5O1f0xOLb0
         a1lmyOxxFhKcG1hc6d5skVZB9KCHmIMXGO6kIvVYD7BdS9WMxqd3ic2cgVAaD4IcBDog
         JcjOjaaFeOqANyptqq3f9Le/aGkGx9RgGV4lDOBcWAcxZDyIb61grNtknix4W5xta6mP
         0sOfxQLnzAXWnf2La8WrxDmhxQBRB2InWks/b14RJFlX3Vz/6mgqFANnwcjVD0Vk49Ra
         e59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794757450; x=1795362250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vUVVF4AJI6A1KyF5MrpgJ8wgNYqK81vISWpwSYQrSjM=;
        b=DlZ4GqXlVvIYJ08YnKiiIWh2+JUOfEC0lJIYbsYxguz7os+vxq//3fqPeKU6xztFEl
         PEtb/qqNgHTrSFj+VU53gQMXASHtv+pqkTAfJZjxzWv0Cbd1bm2JwFDMsoswR9+owo41
         wESDfpeQ1Ip8zDZtZVB4aA3ydOtRmuLX5AFa3bK5lRniAb6G+Xk2vTd3ErXnrnVgsNZG
         9risnTsJHE4yMHU8w1ESww4R60u7gqA6d6tkVagYRRzQtnu0cUj2WwMBfty78bKEwQMt
         lhKYPe8Cu5aY6Vg9RyqGM8IEKOHDJ4KBrRC4UD7m+zReildBXcJ5u6Uq7Xe1FaTsgjrG
         cgEQ==
X-Gm-Message-State: APuU4Z8wqMtM6skSX+5b1NWibgQqzOUntFZSxRZD1AM8lH/EAzmq8YRL
	FXgWz7AdVYxwPScUa2RZu1x6hSMRCAYmB7+hRkfHQZeeibQAYKdcsgJh9ZwHIBNc4nRkbG6ENZ/
	/UcTwdMtH9awdJlHStQ5ebyrJxMPIq0I=
X-Gm-Gg: AYBFou39ObBykUMIkHiyZn3hcvmqKLYYwyz0FMQQ298f96GGrPvPii1nO4KNf9HAh65
	OR9HU682ZPtIOys6hmvfF3ojbaIIjyP+sh/30l7xpqHKJW6Mwz/5zlNg4OeNMfnrEWDno/pbOyr
	pszPJch/lCdqJEzsqyXTPFp5ylHYbqnp0vY3puujFiqf2EuOHW7lAeqT9/RjB/lLhokdONv2SgE
	WE/g04vAaUxibd7p9IRuM/kGiAkjgN5Pgc9KRhtkQygapEfeAots2x9Qq00jrQMH4CVvh1cW7qu
	2qLLSoGzu11/h7TSG0TR5m4TXsdi4g60Mw3e5Tt5G7FwrkzhbqGIXLs1q2Iligg7oJoQ9kgyJ2x
	xeUmcEtLa05OhQ/ndeoVqb19GqJIAuzTiHGhh2w==
X-Received: by 2002:a05:6512:398f:b0:5c1:5e26:f718 with SMTP id
 2adb3069b0e04-5c170b5a5e6mr2612180e87.54.1794757449354; Sun, 15 Nov 2026
 07:44:09 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115152408.48205-1-shlomojune6@gmail.com>
In-Reply-To: <20261115152408.48205-1-shlomojune6@gmail.com>
From: J4f J4f <shlomojune6@gmail.com>
Date: Sun, 15 Nov 2026 23:43:58 +0800
X-Gm-Features: AclHuK9qCQ2mCgHNUMy8WdZjghDi7aUSo5ReoClKtDYN8vj2Ui9jiLlxMJxuOKM
Message-ID: <CAE_LbwmJGV9jMZWc07PqUevk1LzjDDWfnyuL+3wSEQ-YiEA-Ag@mail.gmail.com>
Subject: Re: [PATCH v1] net: sock_reuseport: check program type on the
 migration path
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, edumazet@kernel.org, kuniyu@google.com, 
	pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org, 
	horms@kernel.org, Linux kernel audit <audit@example.invalid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Nov 2026 at 23:24, Shihuang Liu <shlomojune6@gmail.com> wrote:
>
> From: Linux kernel audit <audit@example.invalid>
>
> A BPF_PROG_TYPE_SOCKET_FILTER program can be loaded with
> expected_attach_type set to BPF_SK_REUSEPORT_SELECT_OR_MIGRATE and
> attached to a SO_REUSEPORT TCP group; both steps are allowed without
> CAP_BPF.  Closing a listener that still has queued children then runs
> that socket filter with a struct sk_reuseport_kern as its context,
> while the program was verified against struct sk_buff.  It reads and
> writes past the 56-byte object on the stack, which KASAN reports as a
> stack-out-of-bounds in ___bpf_prog_run().
>
> The cause is that reuseport_migrate_sock() decides from
> prog->expected_attach_type alone.  That field is supplied by user
> space and does not identify the program type, and
> bpf_prog_load_check_attach() does not reject the value for
> SOCKET_FILTER programs.
>
> Fix this by requiring BPF_PROG_TYPE_SK_REUSEPORT before running the
> program, and use the same check in reuseport_stop_listen_sock().
> Socket filters can still be attached and used as selectors; the
> selection path is unchanged.
>
> Fixes: d5e4ddaeb6ab ("bpf: Support socket migration by eBPF.")
> Signed-off-by: Linux kernel audit <audit@example.invalid>
> ---

My mistake =E2=80=94 I got the From: and Signed-off-by: wrong in v1.  Code =
and
commit message are unchanged; v2 will fix that.

Thanks
Shihuang
>  net/core/sock_reuseport.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -460,6 +460,18 @@
>  }
>  EXPORT_SYMBOL(reuseport_detach_sock);
>
> +/*
> + * Only a BPF_PROG_TYPE_SK_REUSEPORT program is verified against
> + * struct sk_reuseport_kern, which is the context bpf_run_sk_reuseport()
> + * passes to it.  expected_attach_type is set by user space and does not
> + * identify the program type.
> + */
> +static bool reuseport_is_migration_prog(const struct bpf_prog *prog)
> +{
> +       return prog && prog->type =3D=3D BPF_PROG_TYPE_SK_REUSEPORT &&
> +              prog->expected_attach_type =3D=3D BPF_SK_REUSEPORT_SELECT_=
OR_MIGRATE;
> +}
> +
>  void reuseport_stop_listen_sock(struct sock *sk)
>  {
>         if (sk->sk_protocol =3D=3D IPPROTO_TCP) {
> @@ -474,7 +486,7 @@
>                                                  lockdep_is_held(&reusepo=
rt_lock));
>
>                 if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_migrate_req) =
||
> -                   (prog && prog->expected_attach_type =3D=3D BPF_SK_REU=
SEPORT_SELECT_OR_MIGRATE)) {
> +                   reuseport_is_migration_prog(prog)) {
>                         /* Migration capable, move sk from the listening =
section
>                          * to the closed section.
>                          */
> @@ -644,7 +656,7 @@
>
>         hash =3D migrating_sk->sk_hash;
>         prog =3D rcu_dereference(reuse->prog);
> -       if (!prog || prog->expected_attach_type !=3D BPF_SK_REUSEPORT_SEL=
ECT_OR_MIGRATE) {
> +       if (!reuseport_is_migration_prog(prog)) {
>                 if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_migrate_req))
>                         goto select_by_hash;
>                 goto failure;
