Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990291;
	b=P2zFY6Y62BO5SE1uH5dLBihgCMwcn2qxKRtr72zMLXBHMUuZOf5C7xFICBRF53yz+9Xb
	 j5FyOXRtAK+D3WqXrRTfyc2AiuULeEWCwwpErU4Lvtg7ZO5jWc6I3Xy46ByD1itjdAHN8
	 9foBdq58nJq1sINrvuy6VjTVGArPeVMy41oTZ/rW4uGD3tR5Kjc7V7mKX3KwNOmoFfak0
	 TivOZvy5IIxpolAgh1EANomT+zq/bbslQfpon+ofuHq3/wTlenwlI19AsQe7iSlM3yZSZ
	 ZG5kwZqGgcy+Y106fB5AlipesV8Nm7rqAqxxuni2CuYR8xHvyQdmSp2HJWhEqVTf8LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990291;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UliTkuKSwijkprFnPvplR6mcOQUjgocutB6yCvWNZyo=;
	b=3SZEpPbQcaIIpni1ruRdSFbJtVCkbUV4ntccKSM0vFbm5SFegjB2TnNkYwCVxvlyf1JP
	 MOz0rvlf9iK02YRhHTyy6bMKe205pwg9ngbmR6ep/aM4U5wG/DCXSz5kfgjDiEVuTmcWN
	 nBpMxmAhLK6limWGQH+CMVH9n8OV65ytOdWiwa3PLjnHGOY11HkG8Bjyb46wQJYECyyL7
	 Oi3NG8pudgTSx8FU5BWrzmLM6dApFMk4NIqqpMUmaCnmD36sbGBN3bkr9gk00RnaCGiIV
	 0e2En5WcgKWmdjFLLhnoP5LJAefnmXmUhnL4EAFpmt2nyEmjllVz9oa8dBXjVL1GmJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.win;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE5606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 18:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68DE5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so145010266b.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 10:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990290; x=1794595090;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UliTkuKSwijkprFnPvplR6mcOQUjgocutB6yCvWNZyo=;
        b=e2XV/BzhEfGFVIik8DjpTXzoeVw1TkcMFCXkcja4cauLqk6SzIes8Smvy00jJKxjdt
         SME269VgWviAo9+3aO/+dMWWHgw3kqcDFFj16zWLP8gkV5QZ+md6WVLGJN6w9/VDdAKY
         RcTjFrfFpxN8VLx1KUwwTMh16FbJeug61hiJSyDu0m1+3uSFm2t4ivpM0ivTl8Admj8G
         md8BCJ2rsCSs8ztm2uo8NL7TwFkN/+xaRbqiyHgIgPRGoCIhWbFIcWEKJwHUKIpLOodp
         vtGoAON6TkfxfnsEC87M62oREkIbyratOJti90WQPhfZUE60XuX0qNkma6886GPgYp1b
         mPHw==
X-Forwarded-Encrypted: i=1; AKwUvBzrGOJ5SDTW6ZD1ScouFULosKx0SXzbiekluQkn4uwCKxar7F6AZaawTgq0+cE8rd068lg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xo+d/jzt4cp/8+N9kgQeRh8vj35/bvwAgnbmUa9f3Zdhx98Aj
	cwQe9oW9cQpZavVqMid5ZcgUZ1QPl4vwNM+rH7HFBIwED4KPrvMTjHQxO2Xt5FSA2ps=
X-Gm-Gg: AYBFou0q7F8mH2TgCXQD+3S2fCHX3IfxOE+zxhP4QRC4xRgoi/YR0mjXOtcMwEw7VvB
	n4g+We0lrOsgjadrZ58TXV6Gq7gcYqiuR5cjsG5o+d/SH8CuekdKblVrWaqCaU+xSYUtt+b9WNd
	ZiLg4VZaIkqokKFFL7FsbwxjlwaZJKpc9zQdvVomBECWG5Katbkus1yxvELVOsko56cyQUrvBHq
	snncz7/zBuRhVYUr+yh0QHSPD5kE8CKWWVA7KUZB6n8R/XcByzwjKA5RfKyxhQVO0D9mcc6LSP6
	eaYQ0IWJule1K4PKZoc86QTG3MFKCaQemjY0MUdrhHwB6pYZoAF2Qe1qpQq1qBo17t4IYulsF8m
	IBxhc+jt4jGeKkqDFxX4poRcsm3ESsn8/g4XjzO12cOCIxoF5CbbAZ9FbHizdUJXGWEtKAYvb8e
	mFfW4CbNxRT8x0ls32h0D+6TfcYEzCdhXnkKvKY1Z+JB2sw2oyjDM64ROT1HoaLTRmfk3f/1uyL
	VEB75wQ3YxiVYh37630Rvze3ifljhxzrSJfyiNB9OY7qOgFSM4TmVgkREnXhgQNROtgpXtewky4
	Sbfw5oYq0FLNK2WPMtUko7diE6soSdM80A67yv5MPMjzHrZ7KuXTl+h9Tz8=
X-Received: by 2002:a17:907:c0b:b0:c41:731c:534 with SMTP id a640c23a62f3a-c4d352c83c7mr310187166b.24.1793990289528;
        Fri, 06 Nov 2026 10:38:09 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3569b856sm96475566b.46.2026.11.06.10.38.09
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 10:38:09 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4cdc606b47so141552066b.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 10:38:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHPfNVP+xX3ouarT2fshLaZiDH4gIyvJnqeeCfG1U0FagB6F88avOKwNtPvOU//imPtagk=@vger.kernel.org
X-Received: by 2002:a17:907:ea89:b0:c4c:bff4:200c with SMTP id
 a640c23a62f3a-c4d3531f031mr283547466b.32.1793989808075; Fri, 06 Nov 2026
 10:30:08 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029232437.2581640-1-jarkko@kernel.org> <20261029232437.2581640-2-jarkko@kernel.org>
In-Reply-To: <20261029232437.2581640-2-jarkko@kernel.org>
From: Ignat Korchagin <ignat@linux.win>
Date: Fri, 6 Nov 2026 18:29:56 +0000
X-Gmail-Original-Message-ID: <CAOs+rJVNyJwqp4CR-d_T4GVjNMjgbaDL78_mZCVGGvN1xpd33w@mail.gmail.com>
X-Gm-Features: AclHuK8TGNjpH-aL7rdb3WJ8RwrdjoKcrJ52VddwbSIE-hld3YHoMNkMBO-NFbA
Message-ID: <CAOs+rJVNyJwqp4CR-d_T4GVjNMjgbaDL78_mZCVGGvN1xpd33w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] KEYS: Introduce keyring_is_empty()
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, 
	"open list:ASYMMETRIC KEYS" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:DEVICE-MAPPER (LVM)" <dm-devel@lists.linux.dev>, 
	"open list:FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PRO..." <fsverity@lists.linux.dev>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 11:25=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> Introduce keyring_is_empty() in order to decouple for BPF, dm-verity and
> fs-verity how keyring internally manages the keys.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Ignat Korchagin <ignat@linux.win>

> ---
>  drivers/md/dm-verity-verify-sig.c                      |  2 +-
>  fs/verity/signature.c                                  |  2 +-
>  include/linux/key.h                                    |  1 +
>  kernel/bpf/keys.c                                      |  2 +-
>  security/keys/keyring.c                                | 10 ++++++++++
>  .../selftests/dm-verity/test-dm-verity-keyring.sh      |  2 +-
>  6 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-ver=
ify-sig.c
> index aadcf5e4a47c..cad21e9144ed 100644
> --- a/drivers/md/dm-verity-verify-sig.c
> +++ b/drivers/md/dm-verity-verify-sig.c
> @@ -153,7 +153,7 @@ int verity_verify_root_hash(const void *root_hash, si=
ze_t root_hash_len,
>         if (ret !=3D -ENOKEY && ret !=3D -EKEYREJECTED)
>                 return ret;
>
> -       if (dm_verity_keyring->keys.nr_leaves_on_tree &&
> +       if (!keyring_is_empty(dm_verity_keyring) &&
>             dm_verity_keyring->restrict_link)
>                 ret =3D verify_pkcs7_signature(root_hash, root_hash_len,
>                                              sig_data, sig_len,
> diff --git a/fs/verity/signature.c b/fs/verity/signature.c
> index 0302a4e506ec..890d33b9d812 100644
> --- a/fs/verity/signature.c
> +++ b/fs/verity/signature.c
> @@ -67,7 +67,7 @@ int fsverity_verify_signature(const struct fsverity_inf=
o *vi,
>                 return 0;
>         }
>
> -       if (fsverity_keyring->keys.nr_leaves_on_tree =3D=3D 0) {
> +       if (keyring_is_empty(fsverity_keyring)) {
>                 /*
>                  * The ".fs-verity" keyring is empty, due to builtin sign=
atures
>                  * being supported by the kernel but not actually being u=
sed.
> diff --git a/include/linux/key.h b/include/linux/key.h
> index c4486e938a06..20ca43f5eab1 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -439,6 +439,7 @@ extern int restrict_link_reject(struct key *keyring,
>                                 struct key *restriction_key);
>
>  extern int keyring_clear(struct key *keyring);
> +bool keyring_is_empty(const struct key *keyring);
>
>  extern key_ref_t keyring_search(key_ref_t keyring,
>                                 struct key_type *type,
> diff --git a/kernel/bpf/keys.c b/kernel/bpf/keys.c
> index bffc356839ac..24e0416abc99 100644
> --- a/kernel/bpf/keys.c
> +++ b/kernel/bpf/keys.c
> @@ -29,7 +29,7 @@ struct bpf_key *bpf_lookup_keyring(void)
>
>         if (!bpf_keyring)
>                 return NULL;
> -       if (!READ_ONCE(bpf_keyring->keys.nr_leaves_on_tree) ||
> +       if (keyring_is_empty(bpf_keyring) ||
>             !READ_ONCE(bpf_keyring->restrict_link))
>                 return NULL;
>
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 5281da9d5bf7..ac48d6204915 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -443,6 +443,16 @@ static void keyring_destroy(struct key *keyring)
>         assoc_array_destroy(&keyring->keys, &keyring_assoc_array_ops);
>  }
>
> +/**
> + * keyring_is_empty - Check whether a keyring is empty
> + * @keyring: The keyring to check.
> + */
> +bool keyring_is_empty(const struct key *keyring)
> +{
> +       return READ_ONCE(keyring->keys.nr_leaves_on_tree) =3D=3D 0;
> +}
> +EXPORT_SYMBOL(keyring_is_empty);
> +
>  /*
>   * Describe a keyring for /proc.
>   */
> diff --git a/tools/testing/selftests/dm-verity/test-dm-verity-keyring.sh =
b/tools/testing/selftests/dm-verity/test-dm-verity-keyring.sh
> index 1f9601ef22f8..792449d356cf 100755
> --- a/tools/testing/selftests/dm-verity/test-dm-verity-keyring.sh
> +++ b/tools/testing/selftests/dm-verity/test-dm-verity-keyring.sh
> @@ -746,7 +746,7 @@ test_keyring_inactive_when_empty() {
>      log_info "TEST: Verify dm-verity keyring is inactive when sealed emp=
ty"
>
>      # When keyring_unsealed=3D0, the keyring is sealed immediately while=
 empty
> -    # This means it should NOT be used for verification (nr_leaves_on_tr=
ee=3D0)
> +    # An empty keyring should NOT be used for verification.
>
>      log_info "Keyring state (should be empty and sealed):"
>      list_keyring_keys
> --
> 2.47.3
>
>
