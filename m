Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B9456E18
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668595; cv=none; b=cycGnigVbU5eHwgVkROn09agzW6UvRkH91zKKDBNVuss+BippzaLyTCe4SIj67bMbgL8JNyRO7h1GKkHbOEQCDKB0u7gg6VwP4ctYSds/dJ6RuGVq/F3He2L7HoF8EuRQRe+0uF2LB3gKr4gGJAg5OVeG7bLRvh8yUXAqXARDQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668595; c=relaxed/simple;
	bh=pLmXLc5ToL1/D6VDfbHEeT+H+Na3VDMWmj+WOh6a99k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJ8liRYEqjpNA27hjMhvwKufcXwHdu7kaUdB1ALEEjvYsNh7V7eh/6qNn6S3qhST43ea/84/HmuAw91rmbeNZRYq5nxGnRFXxhnUm8XhGoA1/p4XCzwPlWJY0+iHddYK/K/aOc92eaz8vFbUim17OE5IkrsjgiGuIheyMbTy+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NneNl+SN; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NneNl+SN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Hxoczt3+5+3WU+eBXfR1lExqgArXUZ7d/MTHzAoKmZo=; b=NneNl+SNPbmDZLZJ1DFNZ0sXRi
	YVDGjndm/OCOn8Wy2EUJMH+XFoEz0L8j5KuQDMVm/lP3/SXVz7n+wheY9sohLDAimEIUFc9qYBQht
	dRUFR1fi05Qx6NMZrF0lms7Poo66w6lL37jJUZFSStM4n3d7nr0yKQNrt5q4FdX21CA7hCkURZanJ
	NUCBcyj30nZKhRR6fBKMw04PhBdmHBF9RQO9PTr6crertfkRRaiskzGOfsf1bIknq+guVKZthluEu
	4TEfPy3PT5uk61LZQqwzpOBHjpRbjGeJCwtNw7MfY9LVoH3U+Bp5rWZ9prYjnpJjJO7OZDKLPWNyY
	q+hVlNfA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wysGN-000PLR-16;
	Tue, 25 Aug 2026 16:36:31 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wysGM-000NKf-2e;
	Tue, 25 Aug 2026 16:36:30 +0200
Message-ID: <28573444-7881-48e7-9046-c63f03fe06e7@iogearbox.net>
Date: Tue, 25 Aug 2026 16:36:30 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 01/11] bpf: Add a bpf keyring for program
 signature validation
To: Christian Brauner <brauner@kernel.org>
Cc: memxor@gmail.com, kpsingh@kernel.org, ast@kernel.org,
 john.fastabend@gmail.com, a.s.protopopov@gmail.com, bpf@vger.kernel.org
References: <20260821214111.1120748-1-daniel@iogearbox.net>
 <20260821214111.1120748-2-daniel@iogearbox.net>
 <20260825-deeskalation-anheben-seefahrt-b9954138eb53@brauner>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260825-deeskalation-anheben-seefahrt-b9954138eb53@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28103/Tue Aug 25 08:27:08 2026)

On 8/25/26 4:20 PM, Christian Brauner wrote:
>> BPF program signatures can currently be verified against one of the
>> system keyrings (builtin, secondary, platform) or against an arbitrary
>> user/session caller-supplied keyring named through keyring_id. There
>> is nothing in between: the system keyrings need a kernel rebuild or a
>> vouched-for enrollment to rotate a key, while a caller-supplied keyring
>> is fully controlled by the loader and therefore carries no trust on
>> its own (unless explicitly combined with BPF LSM to protect against
>> key tampering).
>>
>> Add a dedicated bpf keyring to fill that gap, modelled after the
>> dm-verity keyring which was added in commit 033724b1c627 ("dm-verity:
>> add dm-verity keyring") and which can eventually be used also via
>> systemd through the same enrollment method as in dm-verity's case. It
>> is selected with the new well-known keyring_id VERIFY_USE_BPF_KEYRING
>> and gives an operator a place to enroll a BPF-only signing key at boot,
>> specifically scoped to BPF program loading and nothing else in the
>> kernel's trust hierarchy.
>>
>> By default the keyring is sealed empty at init. Systems that want to
>> provision keys pass bpf.keyring_unsealed=1, which leaves the keyring
>> open for the initrd to add keys to. The keyring is only ever consulted
>> once it is both non-empty and restricted. An unrestricted keyring is
>> ignored.
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> Looks great,
> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks for the review!

[...]
>> diff --git a/include/linux/verification.h b/include/linux/verification.h
>> index dec7f2beabfd..1cb59ddda250 100644
>> --- a/include/linux/verification.h
>> +++ b/include/linux/verification.h
>> @@ -18,6 +18,16 @@
>>   #define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
>>   #define VERIFY_USE_PLATFORM_KEYRING  ((struct key *)2UL)
>>   
>> +/*
>> + * The id of BPF's ".bpf" keyring, reserved from the same space. It is
>> + * explicitly not a sentinel like the two above as BPF resolves it to
>> + * the keyring itself and passes that, so verify_pkcs7_signature() never
>> + * sees this value, and system_keyring_id_check() must keep rejecting it.
>> + * Left as a plain integer so that handing it over as @trusted_keys does
>> + * not compile.
> 
> 
>> + */
>> +#define VERIFY_USE_BPF_KEYRING	3
> 
> 
> 
> 
>> +
>>   static inline int system_keyring_id_check(u64 id)
>>   {
>>   	if (id > (unsigned long)VERIFY_USE_PLATFORM_KEYRING)
> 
> 
>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>> index 90255d80e5be..9a92c348bbda 100644
>> --- a/kernel/bpf/Makefile
>> +++ b/kernel/bpf/Makefile
>> @@ -27,6 +27,9 @@ obj-$(CONFIG_BPF_SYSCALL) += offload.o
>>   obj-$(CONFIG_BPF_SYSCALL) += net_namespace.o
>>   obj-$(CONFIG_BPF_SYSCALL) += tcx.o
>>   endif
>> +ifeq ($(CONFIG_KEYS),y)
>> +obj-$(CONFIG_BPF_SYSCALL) += keys.o
>> +endif
>>   ifeq ($(CONFIG_PERF_EVENTS),y)
>>   obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
>>   endif
>> diff --git a/kernel/bpf/keys.c b/kernel/bpf/keys.c
>> new file mode 100644
>> index 000000000000..dc4d3a33158a
>> --- /dev/null
>> +++ b/kernel/bpf/keys.c
>> @@ -0,0 +1,67 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (c) 2026 Isovalent */
>> +
>> +#include <linux/bpf.h>
>> +#include <linux/cred.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/key.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/slab.h>
>> +
>> +#undef MODULE_PARAM_PREFIX
>> +#define MODULE_PARAM_PREFIX "bpf."
>> +
>> +static struct key *bpf_keyring;
>> +
>> +static bool bpf_keyring_unsealed __ro_after_init;
>> +module_param_named(keyring_unsealed, bpf_keyring_unsealed, bool, 0444);
>> +MODULE_PARM_DESC(keyring_unsealed, "Leave the bpf keyring unsealed");
>> +
>> +struct bpf_key *bpf_lookup_keyring(void)
>> +{
>> +	struct bpf_key *bkey;
>> +
>> +	if (!bpf_keyring)
>> +		return NULL;
>> +	if (!READ_ONCE(bpf_keyring->keys.nr_leaves_on_tree) ||
>> +	    !READ_ONCE(bpf_keyring->restrict_link))
>> +		return NULL;
>> +
>> +	bkey = kmalloc_obj(*bkey);
>> +	if (!bkey)
>> +		return NULL;
>> +
>> +	bkey->key = bpf_keyring;
>> +	bkey->has_ref = false;
>> +	return bkey;
>> +}
>> +
>> +static int __init bpf_keyring_init(void)
>> +{
>> +	struct key *keyring;
>> +
>> +	keyring = keyring_alloc(".bpf",
>> +				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
>> +				current_cred(), KEY_POS_SEARCH |
>> +				KEY_USR_VIEW | KEY_USR_READ |
>> +				KEY_USR_WRITE | KEY_USR_SEARCH |
>> +				KEY_USR_SETATTR, KEY_ALLOC_NOT_IN_QUOTA,
>> +				NULL, NULL);
>> +	if (IS_ERR(keyring)) {
>> +		pr_err("bpf: cannot allocate bpf keyring: %ld\n",
>> +		       PTR_ERR(keyring));
>> +		return 0;
>> +	}
>> +	if (!bpf_keyring_unsealed &&
>> +	    keyring_restrict(make_key_ref(keyring, true), NULL, NULL)) {
>> +		pr_err("bpf: cannot seal bpf keyring\n");
>> +		key_revoke(keyring);
>> +		key_put(keyring);
>> +		return 0;
>> +	}
>> +
>> +	bpf_keyring = keyring;
>> +	return 0;
>> +}
>> +late_initcall(bpf_keyring_init);
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 2f330230f8d5..92097b2d24a8 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20042,6 +20042,8 @@ static enum bpf_sig_keyring bpf_classify_keyring(s32 keyring_id)
>>   		return BPF_SIG_KEYRING_SECONDARY;
>>   	case (s32)(unsigned long)VERIFY_USE_PLATFORM_KEYRING:
>>   		return BPF_SIG_KEYRING_PLATFORM;
>> +	case VERIFY_USE_BPF_KEYRING:
>> +		return BPF_SIG_KEYRING_BPF;
>>   	default:
>>   		return BPF_SIG_KEYRING_USER;
>>   	}
>> @@ -20077,10 +20079,17 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
>>   	if (!attr->signature_size ||
>>   	    attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
>>   		return -EINVAL;
>> -	if (system_keyring_id_check(attr->keyring_id) == 0)
>> +	if (attr->keyring_id == VERIFY_USE_BPF_KEYRING) {
>> +		key = bpf_lookup_keyring();
> 
> Hm, I think this is fragile. The keyring serial allocation mechanism
> only reserves 1 and 2. If you want to give userspace a stable handle you
> need to do something like:

Sorry, looks like our email timing raced each other (just sent a v2 with
feedback from LLMs addressed). I'll look into the addressing the below in
a v3 later this week then.

>    --- a/include/uapi/linux/keyctl.h
>    +#define KEY_SPEC_BPF_KEYRING   -9      /* - key ID for the .bpf keyring */
> 
>    --- a/security/keys/process_keys.c
>    +/* the .bpf keyring */
>    +static struct key __rcu *bpf_keyring;
>    +
>    +void key_register_bpf_keyring(struct key *keyring)
>    +{
>    +     rcu_assign_pointer(bpf_keyring, keyring);
>    +}
>    +
>    +void key_unregister_bpf_keyring(void)
>    +{
>    +     RCU_INIT_POINTER(bpf_keyring, NULL);
>    +     synchronize_rcu();
>    +}
>     ...
>     key_ref_t lookup_user_key(...)
>    +     case KEY_SPEC_BPF_KEYRING:
>    +             rcu_read_lock();
>    +             key = rcu_dereference(bpf_keyring);
>    +             if (key)
>    +                     __key_get(key);
>    +             rcu_read_unlock();
>    +             if (!key)
>    +                     goto error;
>    +             key_ref = make_key_ref(key, 0);
>    +             break;
> 
> 
> And then slot the key_{un}register_bpf_keyring() helpers into the part
> where you set up the bpf keyring. I don't think you ever unset so you
> can probably drop key_unregister_bpf_keyring() though.
> 
> Otherwise looks great to me.
> 

