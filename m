Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE8391841
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837390; cv=pass; b=ofEwRar9aliqoipu4mdcwnwAQiwYzmI8MMGAmnkMVgDuKArvTZyjSdhaY34fAcyteOkCvXG5pPJTL+vFHrurZSnuj3L5Y2KwQgz7C+ram4X7/9pnGIleKcwVbB/jUOZTFYpaLBpwd3mxtX40CSeMJkqMmpcolc6/0ed6yhcXgxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837390; c=relaxed/simple;
	bh=B5l17OTVu2cjpFOePRpq3p9C6pV9J6gN+48MxLiURD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrRDQzyBT22J/5pzKRUcmIltD8PB3A8Eq4oPkeH1LNOdeseKKbcpjWeIa8qDJs1EqPAkLEX4wz+ppnGgzU0lV145ybSljl+sz9C6sZ1T3INMGNfzMUdtYZcno2FLbTq2D8Yra/zClD8NSa3rEk2nAD81zFTXmQVHky/FJVY9RRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmRIGMgV; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmRIGMgV"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59dcdf60427so4332386e87.3
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 19:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774837386; cv=none;
        d=google.com; s=arc-20240605;
        b=SPMhGSOgMa7FQKkvnJyJcQnXjLysiGqXvkk7LjYUmFblA9lOkkCo3NSbaxA02MQrjS
         Gmz3bPheszuwNJOKEq4el0bNkjSbcRtRYp30h9HB04HOTPYx9rymwnux7wYK1DTjsCiN
         m4mnzmllDhLZZ2mipnxLGEVTR0pi5k6Ypx9DJIXXL5PePDWPKhk5iqGyrOJe+LZo1zlA
         REoi0Hb7DgZPEImQX2qflfU7BfpcLtK/xMbCBW3+RMXdSGa9170hYTCxM2q8Gyndo5Wg
         G/im6cRgOwYdGj2tHUkDsolqcyTdx70fJ2S9wTGCAc/4gYzKTSKJPGam+Sf/n6vqXtH/
         DjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ek5GIhyIQVD3wLj7CUw7tIfTz6hifMBva7KkCCkNds=;
        fh=4Zhei73xmJ0mr0JoueGkLZoM4Mr6uF0qGCQ/pOqjoBU=;
        b=ZUj3aS6d+zKB02um3R03E1u4/oUuMz7iG8Q+BTErIllSeib9dfa7kTiowDZDXOoJ1C
         1IdISb6bgp6TXCGWiMtCq4cPfpL7ZRMF2IXbKC2P5Zey/BRjRQyA3Q0Zp/7aLS4gB5Jv
         AygtQoPD4qLfUf91yYob7JCOa8xwUsdkQft10xTXNBtgqeOCnJtFbXi1185qyMczDvyq
         qnwwN2Lstppu0DMgsuUVOVdaBpaHLpkXM1Iq6o4ZzAHO4GEapEXS67OhqKwbjmNWQ1lu
         xWbXDkZD54RgcU7tZGKztok7CB8jGcnOJ39lUlfnTkS9Cs7OcHha/wNHrmqdmnRJ+4ZQ
         gwkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774837386; x=1775442186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ek5GIhyIQVD3wLj7CUw7tIfTz6hifMBva7KkCCkNds=;
        b=FmRIGMgVrUJGcBtoP/133eOBuwfrg/TxHiOSLyvg7kTMxya3DQg1GF5HLNfb1sb9lj
         B/QJprB8Emrp7pbGOBrpXHSQAehB+JnBLqtXLfSnRVJRHuH7IIYLPXQcebWQjR/3QKdq
         pYaT+PTgdWL/tldY7VPwm5wjVvcrtB5xx+RbXBcxBLxZZTIVVW8uAOqyTY4ALlhfsO+2
         X/nWwrHb1CVTliaC3HrtopttsG+SRlBLdzzMl+60MzUXLjUD759m42SluhuBmZXrXFRJ
         VTPGiQSnM0plIEROQ6781PiJAaKACSA2dOCwKMHja1qrYnQHDfphRpI8clcDTAQBsOgD
         OwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774837386; x=1775442186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ek5GIhyIQVD3wLj7CUw7tIfTz6hifMBva7KkCCkNds=;
        b=If86ttn+zLSFjBvGI16ssCdZWhRf8qpNBhUzxTz053tOZj30MD95/A1iUMU4lDbigw
         99yDOoqnQR7NZCvfBP77y3RapUSvfH4OKLEzGpzoNzogcONdzJ1/0o3WedKeqc6XfC4p
         LdI0fO6FYfbExRAR8T9VywEp8PGPGPw29kVsueg5+VSxhzr1O3DT81IYUgYvHRUo9p5Q
         Z8/zly3lbacjBg0KaJeala7A/8vA/jCmGvAjt+f8MxDIN4C2lZI+dys0UnXh2LdBz7m6
         nG7ilaPF75B3v5vOVyKRL0t7QyJ8eQHsVfpZdvaMGGwMzUB7gImp9c/y3e8sVOI7aPRS
         cnfg==
X-Forwarded-Encrypted: i=1; AJvYcCXTcvNF2Nv0owvmDxQRkvJDTqjwvDKBK9/Xb23Tk/DrWKRMsZFv07uNT5tcCCkkgZR7+2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wxUvpv/mu5KUk9gmmzt/8FZyOM0VOL+6wt6WY1hzwaeAwjeH
	+9ABlqqwO6+mHFByvIBqcJU0cQyPjZTmA9BydjB4jpuKcRAoyj7nicP03r8nolfU9wTzQ2EuYqA
	Sxt2wB8/XYT4Pw78fbufZc+3+EWbSTdc=
X-Gm-Gg: ATEYQzwA2B5Q+jPOAH2WGd5LGaBVM5WZa4e3DVbfPOXoXR4MebBt10uLFkxaqUfydZP
	I5D7W+vDR+dWZN9qSZdz3m35FqNHDUuZnsa1MaMAm7RqPdI6C3OXYTbHpksS7iy6ae/27/UsQnf
	n6pQ98lj6WsVRhnclk0viDz9iynZVoSyoS0E/Q2ZXjPsiQ9/mNOlGqfDSu9QZ+UPeSVNGUTpKS+
	nmKziiuPXxocCzogVERFxtyNgP7MrIZ/PJ1V7CyAVoC9t6r98x6LXyCb9RcYYymfXDvad+N47yH
	FS4uKqzs
X-Received: by 2002:a05:6512:39d1:b0:5a1:3d7f:8fab with SMTP id
 2adb3069b0e04-5a2ab7e8bcdmr3190406e87.6.1774837385352; Sun, 29 Mar 2026
 19:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774701288.git.linpu5433@gmail.com> <6584463e576b7bb3619dc302cfecfb8ca56bc86a.1774701288.git.linpu5433@gmail.com>
In-Reply-To: <6584463e576b7bb3619dc302cfecfb8ca56bc86a.1774701288.git.linpu5433@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 30 Mar 2026 10:22:27 +0800
X-Gm-Features: AQROBzBGnDP9EEjcuGYNnnUp4mCdK5fKKNS026TLBUZX8qdJgLBo5d_G7k5Wzcs
Message-ID: <CAL+tcoAVFuBF48fK5yQs+jksU1w_wpEbLX5G_nzCAMoPP9dJ+Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] xskmap: reject TX-only AF_XDP sockets
To: Linpu Yu <linpu5433@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, sdf@fomichev.me, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bjorn@kernel.org, linux-kernel@vger.kernel.org, 
	yuantan098@gmail.com, yifanwucs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:33=E2=80=AFAM Linpu Yu <linpu5433@gmail.com> wrot=
e:
>
> Reject TX-only AF_XDP sockets from XSKMAP updates. Redirected
> packets always enter the Rx path, where the kernel expects the
> selected socket to have an Rx ring. A TX-only socket can
> currently be inserted into an XSKMAP, and redirecting a packet
> to it crashes the kernel in xsk_generic_rcv().
>
> Keep TX-only AF_XDP sockets valid for pure Tx use, but prevent
> them from being published through XSKMAP.
>
> Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE=
_XSKMAP")
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
> Signed-off-by: Linpu Yu <linpu5433@gmail.com>

Thanks for the exhaustive report and fix!

Please use [patch net-next] or [patch bpf-next] as the targeted tree
for maintainers to easily understand which tree to apply.

> ---
>  net/xdp/xskmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
> index afa457506274c..6dac59ebb5cf0 100644
> --- a/net/xdp/xskmap.c
> +++ b/net/xdp/xskmap.c
> @@ -184,6 +184,10 @@ static long xsk_map_update_elem(struct bpf_map *map,=
 void *key, void *value,
>         }
>
>         xs =3D (struct xdp_sock *)sock->sk;
> +       if (!READ_ONCE(xs->rx)) {
> +               sockfd_put(sock);
> +               return -EINVAL;

Can we use -ENOBUFS as well, like how xsk_recvmsg checks the rx ring?

Otherwise, it looks good to me.

Thanks,
Jason
