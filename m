Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4D36B907;
	Sun, 18 Oct 2026 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340158; cv=none; b=Me8XVTwSMPESA3Lxww19w8UFuK7QnEXVmOU0UOhoJGh4LuKp9euhOi1RefA3gNBWfEGo2mjJ0ayaXkIV+L7p+aAkEIpcz+x7zAURYhM9kVl/YXqei9XWgxCurjhNCOTY8BHASQOUoU8Ku5AB1CGtLHPqsmQFTWGrJLzXeCRl+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340158; c=relaxed/simple;
	bh=gO8Jv3kBbkekLp0M0ToCtUaXdXIZSPp3XpJ2V7vrXaY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ps6l2Tfr6Iyw0Q9WMuSs4u5UNOCEQ1ZbAsbR/nJE0V99UAOJrPe/yGjXsUny+1zub3L+YD7rdaOoEUrrly5FlQRprJkEtkhaspvBNJ3PwsF912XgoVjTj/lun7+Rya4dGsr6PnwEyUpenRJ2M2CmAtCREyVJFLhjWpTQesNtUtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAqnKEVk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAqnKEVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F94A1F000C4;
	Sun, 18 Oct 2026 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792340157;
	bh=RaZ7YViG/iKDytKYEsZTHi1ga7iOXJlQndUMyv3+wMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iAqnKEVkG2SdAI4pTKrRiACJ9ErDgGzKowde85LNyEFcAYAZ9gRbF1BWzoMkIdU95
	 ghBT94l7yw0gUPwTnym9XLMv4Q+90TaqIiL6wwWXUo5kp2KeKtaKMnzZ12Zje8wo1N
	 WxpFSQ5c6k1ZJLqDHG9zuSut3JkxX35pFhON9nGH7ETZMVe9bHbhOFSRgcytV0Xyie
	 yTE09g8EzKf38wQHwlVX0tDZ2tu0kMUvT+ppg82W4/WTwG1JYiK1VFOflAt1IyxCpk
	 3XpgNBYgFoyKZ5xZ9H0voAJMRCvHKMTZXFBZtiTcL7vGraKF9fF8IJJXtbVOGcyHQ0
	 PWG/an5iAzt8w==
Message-ID: <sashiko-outbox-176273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 next 06/15] kallsyms: Optimise symbol name search
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Laight" <david.laight.linux@gmail.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Kees Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261018155206.132411-7-david.laight.linux@gmail.com>
References: <20261018155206.132411-1-david.laight.linux@gmail.com>
 <20261018155206.132411-7-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 16:15:56 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kallsyms: race in set_kallsyms_off_size() causes NULL dereference
- [High] kallsyms: set_kallsyms_off_size() sleeps in atomic context
--

commit d36232e927821c82911022ce5bae7cb3de465edd
Author: David Laight <david.laight.linux@gmail.com>

kallsyms: Optimise symbol name search

This commit optimizes symbol name lookups by indexing the compressed
names table directly instead of the array of symbol values. It supports
both 24-bit and 32-bit offset tables, selecting between them using a
static branch initialized on the first symbol lookup.

> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index d18d78e626db2..31451feac8221 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c

[ ... ]

> @@ -185,14 +216,19 @@ unsigned long kallsyms_sym_address(int idx)
>  	return (unsigned long)offset_to_ptr(kallsyms_offsets + idx);
>  }
> =20
> -static unsigned int get_symbol_seq(int index)
> -{
> -	unsigned int i, seq =3D 0;
> +static DEFINE_STATIC_KEY_TRUE(kallsyms_off_size_24);
> =20
> -	for (i =3D 0; i < 3; i++)
> -		seq =3D (seq << 8) | kallsyms_seqs_of_names[3 * index + i];
> +static inline unsigned int get_symbol_name_offset(unsigned long index)
> +{
> +	if (static_branch_likely(&kallsyms_off_size_24))
> +		return kallsyms_off24_of_names[index].v;
> +	return kallsyms_off32_of_names[index];
> +}
> =20
> -	return seq;
> +static void set_kallsyms_off_size(void)
> +{
> +	if (kallsyms_off_size !=3D 24)
> +		static_branch_disable(&kallsyms_off_size_24);
>  }

[Severity: High]
Can calling static_branch_disable() in set_kallsyms_off_size() sleep in
an atomic or early-boot context when kallsyms_off_size !=3D 24?

static_branch_disable() calls static_key_disable() in
kernel/jump_label.c, which acquires cpus_read_lock() and
jump_label_mutex:

kernel/jump_label.c:static_key_disable() {
	cpus_read_lock();
	static_key_disable_cpuslocked(key);
	cpus_read_unlock();
}

However, kallsyms_lookup_name() -> kallsyms_lookup_names() can be called
first from contexts where sleeping is not allowed:

- lib/codetag.c:get_symbol() calls kallsyms_lookup_name() under
  preempt_disable():

	preempt_disable();
	ret =3D mod ?
		(void *)find_kallsyms_symbol_value(mod, buf) :
		(void *)kallsyms_lookup_name(buf);
	preempt_enable();

- mm/alloc_tag.c:alloc_tag_sec_init() calls kallsyms_lookup_name() during
  start_kernel() -> mm_core_init() while interrupts are disabled and
  before poking_init().

- Non-sleepable runtime or debugger callers such as
  bpf_kallsyms_lookup_name(), kdbgetsymval(), and xmon also invoke
  kallsyms_lookup_name().

> =20
>  static int kallsyms_lookup_names(const char *name,
> @@ -201,15 +237,16 @@ static int kallsyms_lookup_names(const char *name,
>  {
>  	int ret;
>  	int low, mid, high;
> -	unsigned int seq, off;
> +	unsigned int off;
> +
> +	DO_ONCE_LITE(set_kallsyms_off_size);
> =20
>  	low =3D 0;
>  	high =3D kallsyms_num_syms - 1;
> =20
>  	while (low <=3D high) {
>  		mid =3D low + (high - low) / 2;
> -		seq =3D get_symbol_seq(mid);
> -		off =3D get_symbol_offset(seq);
> +		off =3D get_symbol_name_offset(mid);

[Severity: High]
Does DO_ONCE_LITE(set_kallsyms_off_size) allow a concurrent caller to
dereference NULL in get_symbol_name_offset() when kallsyms_off_size =3D=3D =
32?

In scripts/kallsyms.c:write_src(), only kallsyms_off24_of_names or
kallsyms_off32_of_names is emitted, and both are declared __weak in
kernel/kallsyms_internal.h:

extern struct { unsigned int v:24 __packed; } __packed kallsyms_off24_of_na=
mes[] __weak;
extern u32 kallsyms_off32_of_names[] __weak;

When kallsyms_off_size =3D=3D 32, kallsyms_off24_of_names resolves to NULL,
while kallsyms_off_size_24 starts enabled via
DEFINE_STATIC_KEY_TRUE(kallsyms_off_size_24).

In include/linux/once_lite.h, __ONCE_LITE_IF() sets __already_done =3D true
before executing set_kallsyms_off_size() and does not wait for it to
finish:

		if (unlikely(__ret_cond) && unlikely(!__already_done)) {
			__already_done =3D true;
			__ret_once =3D true;
		}

If two CPUs call kallsyms_lookup_names() concurrently for the first time
while the first CPU is still inside set_kallsyms_off_size() ->
static_branch_disable(&kallsyms_off_size_24), the second CPU sees
__already_done =3D=3D true and proceeds directly to
get_symbol_name_offset(mid). Since kallsyms_off_size_24 has not been
patched yet, get_symbol_name_offset() evaluates
kallsyms_off24_of_names[index].v and dereferences NULL.

[ ... ]

>
>
>
>
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018155206.1324=
11-1-david.laight.linux@gmail.com?part=3D6
