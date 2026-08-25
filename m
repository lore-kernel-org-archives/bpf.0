Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74043FBEC1
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667620; cv=none; b=Nl6psJr5NrH5xwo/01GsEAHS0d/J8sIffrXbDpS/5qMQbAl/YQ11ODPi5GeZk/nZu47f+OOJLxXb6j0VVZyDRMZ/TLTIUE4DusHp4k+xoAD1ru9+vONth9SY0QG9sbBSS8SkBsh7G2uAeo5SCmFJjvDTmZtr7r3FXHhRzn2X5s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667620; c=relaxed/simple;
	bh=9QlU3l/9/gYx+LPe2tz24oQ6Xb4dZCHS/N6yBRQ5s7Y=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dhcYHeDbUzLjkIhPq/iPIx0FIs4DoTLoCQ/4enIl5ge4ghg6Jj3PHfpgdYr/jqVCvNuSTSLrRO7TggesGjEpcBULqd7Z4OPS9MLU8P8u+zPLvxTwvoeVwzk109mw3rDwMygqYf4toOE5nFr+JfEb65aUROtQimQHVd9mcf/ZfhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW4FO5TF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW4FO5TF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3421F00A3A;
	Tue, 25 Aug 2026 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787667618;
	bh=plwk6tEB3rAh0bJGeqkSpzUoyoKf4Pf5qSe4D/6skAw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=oW4FO5TFLtnij4q3F5ObM8bt4ag6j2d5PL7aN6F8x+M1gr3JBrP7bUk5ntN3fTg3o
	 tH/UBgctVFX1tsF4mHGHfYD6Yji0Lnc6GoPU/M66Ww4i3ePBiB0SuLa7zNOOFa4w5f
	 UpoEoX60wUleQSsn9zRDcAkHtImVtNVP4MJ7IXvj5dQVXcQ1UOvuPSp7UXMUn825SR
	 xePb6Rom3TFqqwUg4URkhKVTWz62UQskY2J6RxdYyn8d4YuR9+OaeRccuzlj7dNYOn
	 KZTksluO/G6ww1SVKuJPoDpee8/C9GfI5wkvTrykHNCiE4M+TKb7kblt0VRSXtTivp
	 ZBX7uQyFXlgvw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next 01/11] bpf: Add a bpf keyring for program
 signature validation
From: Christian Brauner <brauner@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, brauner@kernel.org, kpsingh@kernel.org, 
 ast@kernel.org, john.fastabend@gmail.com, a.s.protopopov@gmail.com, 
 bpf@vger.kernel.org
In-Reply-To: <20260821214111.1120748-2-daniel@iogearbox.net>
References: <20260821214111.1120748-1-daniel@iogearbox.net>
 <20260821214111.1120748-2-daniel@iogearbox.net>
Date: Tue, 25 Aug 2026 16:20:12 +0200
Message-Id: <20260825-deeskalation-anheben-seefahrt-b9954138eb53@brauner>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9044; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9QlU3l/9/gYx+LPe2tz24oQ6Xb4dZCHS/N6yBRQ5s7Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT1LllQr7DcyLhw+17N4MpViw0O2584PF9M/KqlO9fuP
 O5rRxO2dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkxiZGhv7WVVxLgtXE9UOm
 scZVhCVt+ck4f17y4V8aG1nrM2P3tDMyHN8xW3zph1f5prwL5p8W2Hk1/2cbU/IvrknxHVnpBz4
 aMwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> BPF program signatures can currently be verified against one of the
> system keyrings (builtin, secondary, platform) or against an arbitrary
> user/session caller-supplied keyring named through keyring_id. There
> is nothing in between: the system keyrings need a kernel rebuild or a
> vouched-for enrollment to rotate a key, while a caller-supplied keyring
> is fully controlled by the loader and therefore carries no trust on
> its own (unless explicitly combined with BPF LSM to protect against
> key tampering).
> 
> Add a dedicated bpf keyring to fill that gap, modelled after the
> dm-verity keyring which was added in commit 033724b1c627 ("dm-verity:
> add dm-verity keyring") and which can eventually be used also via
> systemd through the same enrollment method as in dm-verity's case. It
> is selected with the new well-known keyring_id VERIFY_USE_BPF_KEYRING
> and gives an operator a place to enroll a BPF-only signing key at boot,
> specifically scoped to BPF program loading and nothing else in the
> kernel's trust hierarchy.
> 
> By default the keyring is sealed empty at init. Systems that want to
> provision keys pass bpf.keyring_unsealed=1, which leaves the keyring
> open for the initrd to add keys to. The keyring is only ever consulted
> once it is both non-empty and restricted. An unrestricted keyring is
> ignored.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Looks great,
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b5493a7f8f22..e331c2fec612 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -663,6 +663,14 @@ Kernel parameters
>  
>  			See Documentation/admin-guide/bootconfig.rst
>  
> +	bpf.keyring_unsealed=
> +			[BPF] When set to 1, leave the bpf keyring unsealed
> +			after initialization so that userspace can provision
> +			keys. Once the keyring is restricted it becomes active
> +			and can be used for BPF program signature verification.
> +
> +			See Documentation/bpf/signing.rst
> +
>  	bttv.card=	[HW,V4L] bttv (bt848 + bt878 based grabber cards)
>  	bttv.radio=	Most important insmod options are available as
>  			kernel args too.
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ffa5626411ac..240e527c864b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1735,6 +1735,7 @@ enum bpf_sig_keyring {
>  	BPF_SIG_KEYRING_SECONDARY,
>  	BPF_SIG_KEYRING_PLATFORM,
>  	BPF_SIG_KEYRING_USER,
> +	BPF_SIG_KEYRING_BPF,
>  };
>  
>  struct bpf_prog_aux {
> @@ -3819,6 +3820,7 @@ struct bpf_key {
>  #if defined(CONFIG_KEYS) && defined(CONFIG_BPF_SYSCALL)
>  struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags);
>  struct bpf_key *bpf_lookup_system_key(u64 id);
> +struct bpf_key *bpf_lookup_keyring(void);
>  void bpf_key_put(struct bpf_key *bkey);
>  int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
>  			       const struct bpf_dynptr *sig_p,
> @@ -3839,6 +3841,11 @@ static inline struct bpf_key *bpf_lookup_system_key(u64 id)
>  	return NULL;
>  }
>  
> +static inline struct bpf_key *bpf_lookup_keyring(void)
> +{
> +	return NULL;
> +}
> +
>  static inline void bpf_key_put(struct bpf_key *bkey)
>  {
>  }
> diff --git a/include/linux/verification.h b/include/linux/verification.h
> index dec7f2beabfd..1cb59ddda250 100644
> --- a/include/linux/verification.h
> +++ b/include/linux/verification.h
> @@ -18,6 +18,16 @@
>  #define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
>  #define VERIFY_USE_PLATFORM_KEYRING  ((struct key *)2UL)
>  
> +/*
> + * The id of BPF's ".bpf" keyring, reserved from the same space. It is
> + * explicitly not a sentinel like the two above as BPF resolves it to
> + * the keyring itself and passes that, so verify_pkcs7_signature() never
> + * sees this value, and system_keyring_id_check() must keep rejecting it.
> + * Left as a plain integer so that handing it over as @trusted_keys does
> + * not compile.


> + */
> +#define VERIFY_USE_BPF_KEYRING	3




> +
>  static inline int system_keyring_id_check(u64 id)
>  {
>  	if (id > (unsigned long)VERIFY_USE_PLATFORM_KEYRING)


> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 90255d80e5be..9a92c348bbda 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -27,6 +27,9 @@ obj-$(CONFIG_BPF_SYSCALL) += offload.o
>  obj-$(CONFIG_BPF_SYSCALL) += net_namespace.o
>  obj-$(CONFIG_BPF_SYSCALL) += tcx.o
>  endif
> +ifeq ($(CONFIG_KEYS),y)
> +obj-$(CONFIG_BPF_SYSCALL) += keys.o
> +endif
>  ifeq ($(CONFIG_PERF_EVENTS),y)
>  obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
>  endif
> diff --git a/kernel/bpf/keys.c b/kernel/bpf/keys.c
> new file mode 100644
> index 000000000000..dc4d3a33158a
> --- /dev/null
> +++ b/kernel/bpf/keys.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 Isovalent */
> +
> +#include <linux/bpf.h>
> +#include <linux/cred.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/key.h>
> +#include <linux/moduleparam.h>
> +#include <linux/slab.h>
> +
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX "bpf."
> +
> +static struct key *bpf_keyring;
> +
> +static bool bpf_keyring_unsealed __ro_after_init;
> +module_param_named(keyring_unsealed, bpf_keyring_unsealed, bool, 0444);
> +MODULE_PARM_DESC(keyring_unsealed, "Leave the bpf keyring unsealed");
> +
> +struct bpf_key *bpf_lookup_keyring(void)
> +{
> +	struct bpf_key *bkey;
> +
> +	if (!bpf_keyring)
> +		return NULL;
> +	if (!READ_ONCE(bpf_keyring->keys.nr_leaves_on_tree) ||
> +	    !READ_ONCE(bpf_keyring->restrict_link))
> +		return NULL;
> +
> +	bkey = kmalloc_obj(*bkey);
> +	if (!bkey)
> +		return NULL;
> +
> +	bkey->key = bpf_keyring;
> +	bkey->has_ref = false;
> +	return bkey;
> +}
> +
> +static int __init bpf_keyring_init(void)
> +{
> +	struct key *keyring;
> +
> +	keyring = keyring_alloc(".bpf",
> +				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> +				current_cred(), KEY_POS_SEARCH |
> +				KEY_USR_VIEW | KEY_USR_READ |
> +				KEY_USR_WRITE | KEY_USR_SEARCH |
> +				KEY_USR_SETATTR, KEY_ALLOC_NOT_IN_QUOTA,
> +				NULL, NULL);
> +	if (IS_ERR(keyring)) {
> +		pr_err("bpf: cannot allocate bpf keyring: %ld\n",
> +		       PTR_ERR(keyring));
> +		return 0;
> +	}
> +	if (!bpf_keyring_unsealed &&
> +	    keyring_restrict(make_key_ref(keyring, true), NULL, NULL)) {
> +		pr_err("bpf: cannot seal bpf keyring\n");
> +		key_revoke(keyring);
> +		key_put(keyring);
> +		return 0;
> +	}
> +
> +	bpf_keyring = keyring;
> +	return 0;
> +}
> +late_initcall(bpf_keyring_init);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2f330230f8d5..92097b2d24a8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20042,6 +20042,8 @@ static enum bpf_sig_keyring bpf_classify_keyring(s32 keyring_id)
>  		return BPF_SIG_KEYRING_SECONDARY;
>  	case (s32)(unsigned long)VERIFY_USE_PLATFORM_KEYRING:
>  		return BPF_SIG_KEYRING_PLATFORM;
> +	case VERIFY_USE_BPF_KEYRING:
> +		return BPF_SIG_KEYRING_BPF;
>  	default:
>  		return BPF_SIG_KEYRING_USER;
>  	}
> @@ -20077,10 +20079,17 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
>  	if (!attr->signature_size ||
>  	    attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
>  		return -EINVAL;
> -	if (system_keyring_id_check(attr->keyring_id) == 0)
> +	if (attr->keyring_id == VERIFY_USE_BPF_KEYRING) {
> +		key = bpf_lookup_keyring();

Hm, I think this is fragile. The keyring serial allocation mechanism
only reserves 1 and 2. If you want to give userspace a stable handle you
need to do something like:

  --- a/include/uapi/linux/keyctl.h
  +#define KEY_SPEC_BPF_KEYRING   -9      /* - key ID for the .bpf keyring */

  --- a/security/keys/process_keys.c
  +/* the .bpf keyring */
  +static struct key __rcu *bpf_keyring;
  +
  +void key_register_bpf_keyring(struct key *keyring)
  +{
  +     rcu_assign_pointer(bpf_keyring, keyring);
  +}
  +
  +void key_unregister_bpf_keyring(void)
  +{
  +     RCU_INIT_POINTER(bpf_keyring, NULL);
  +     synchronize_rcu();
  +}
   ...
   key_ref_t lookup_user_key(...)
  +     case KEY_SPEC_BPF_KEYRING:
  +             rcu_read_lock();
  +             key = rcu_dereference(bpf_keyring);
  +             if (key)
  +                     __key_get(key);
  +             rcu_read_unlock();
  +             if (!key)
  +                     goto error;
  +             key_ref = make_key_ref(key, 0);
  +             break;


And then slot the key_{un}register_bpf_keyring() helpers into the part
where you set up the bpf keyring. I don't think you ever unset so you
can probably drop key_unregister_bpf_keyring() though.

Otherwise looks great to me.

-- 

