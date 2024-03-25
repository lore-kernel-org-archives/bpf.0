Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09422F41
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388589; cv=none; b=HZPdyQYfZqIAATXHaBKwtHHWguv3xodlWYuY97ZlS7jce+VVs7tuDdwUtAE46cREzOOlD7xKCSCIkGF9eXn1yH5mQywPphPEPNxvlxEll4nucFfH59tjtbkc9+D6qoJKSSYXaJWbevKdCsf84sK2xDz6WAS6FKcnDwReVLXhjEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388589; c=relaxed/simple;
	bh=FJBEpiiJtVhXt272bDQJNgkUFqZHG3GyatiuojGilxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5cKaWV78vCSqaUBcCP1oEkNoBohFNJubPpfX7CkBtAwIV8W8428pcBCAOa9ecmMTFb6a2zSwtj1J/ySqsIQHAGN+JTZrUFG3tTD+PfixgDLZnR9MI86Um1v0c181jeRSW3LUSoBHB9sIzBpa65yG99EZvdciyscO7hDMUnGUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=MJ4ZH+7D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gNsoZfmY; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="MJ4ZH+7D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gNsoZfmY"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id D00545C004A;
	Mon, 25 Mar 2024 13:43:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 13:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711388585; x=1711474985; bh=FTyfdCqIhj
	BkN0bcUGbeJNf+bkVgy4o9mFrt5db7whc=; b=MJ4ZH+7DVeR9wDVbPOwCbEw2Tp
	0T/wJWJ6uGPxrI+LgOvh3p6gb9N956XtALKnSgH19hycb9tsZJZVTGHKVrEuoGqd
	YL180eU4AofEQrYoPNhhqjxWlsWlw5HEmnyUrAFxA9fdub9uMklx6OTvTb6+03iB
	iBcmoF/P9RjigAK+HMaGJHccQ2kxB10qHwRjRJfFxN8W5rV70Y6the2A+a6EwoIZ
	uZIahTL0uUmIVjICBCpZ+XVrbPXF+k2RKsmStwzUBlUr9NL8Zik9D23T27gJPcWd
	m343CE92VKzR44exz+ZhKCf62zi0kKAi9j8sOnDit7rTg/Hodr/s9ZJ41kHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711388585; x=1711474985; bh=FTyfdCqIhjBkN0bcUGbeJNf+bkVg
	y4o9mFrt5db7whc=; b=gNsoZfmYj3CbpdlCvgVu5M3uB6OHMfGSnEjR9YV1/h+K
	c+nySZ841GXMcwnaP+fI6Hhv2IF7ooTi8gWmCW0APyLgiYOVoQDRgBqKVGDMf4Fz
	moaKotebvAI7cAhzrsiYgyOk/uYPXdVyugfk+RuNL7NX83WabdGDXKR/T71+ltdp
	mRKkhZrxd/DuyW91N/UjTmbg4ix0ngVXdXSKD0TMM6t24e7G4f9f251FnzvjvJnd
	8KNEEGoiwjhuLxffd9Q6HMVPK8hQLrhMpU77I0OSqdCmROtZc3ktU3J0orUOLd/x
	5coY5CpEoI5tOi/MNr40PhdoiST0CXGdx7NMrtOWPg==
X-ME-Sender: <xms:qbcBZrtS8B13CevrxKSvfAv8x5EhTfWFDxoQozFHQoarBRp_XujMQg>
    <xme:qbcBZsdXAWBH5_kRwMbIMoV5gXJ4mTWkzfuaHvtwlokcsZR50DEKBlVW4QF11h1ch
    fVk8Vkh3Q9eLh1Zog>
X-ME-Received: <xmr:qbcBZuyBQ4oSkoCGdtZh7Qb0YojVkuAnJ97Djfh7XojfjD3RCnGX-7Yt6Qetxl3rfweu0QvIAFX7UHR9M4SkIJnQwW9MfzL_gEmS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepgfelteeuteekgeeikeehtefhffelteekieeigfeuffehvdev
    ieetheekffegudevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdig
    hiii
X-ME-Proxy: <xmx:qbcBZqPF6ze-1qMsvW5bcVJxmOBsz0Z4POTVwsbOXHHq7iF9pLhTHg>
    <xmx:qbcBZr9ce2ueG-8q4tD7n9JkC9Cw_AaETv7TJYYqWtza-BRSz0np4Q>
    <xmx:qbcBZqWz1DuuQXBAudJjdxbdQ-65WmgSiP8zz4urZTr69my6ofNX4g>
    <xmx:qbcBZsdMsLcL5UUTDEHTEV_xobL_w-jcsZwhZ8a-KivJSXaX433G2Q>
    <xmx:qbcBZnS9xjiQSj8u_9yzYA5t3K3jKSrWZtjgQ2GXafcFLJdLtpoNRw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 13:43:04 -0400 (EDT)
Date: Mon, 25 Mar 2024 11:43:03 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, jolsa@kernel.org, 
	quentin@isovalent.com, eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v5 2/2] pahole: Inject kfunc decl tags into BTF
Message-ID: <l4wk2ckxk5jicczzoar7qcpp4d5ok5vhn2wi7sz2iubtinh2qd@i2tcjsaqofkc>
References: <cover.1710532093.git.dxu@dxuuu.xyz>
 <088c4362fa9f080c319df7c49bc6a4e1b6ae98e7.1710532093.git.dxu@dxuuu.xyz>
 <6c178658-d5b3-4b71-b385-5ba95349c8ab@oracle.com>
 <Zf2OJdVntC2jZTBG@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf2OJdVntC2jZTBG@x1>

Hi Arnaldo,

On Fri, Mar 22, 2024 at 10:56:53AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Mar 20, 2024 at 12:54:11PM +0000, Alan Maguire wrote:
> > On 15/03/2024 19:48, Daniel Xu wrote:
> > > This commit teaches pahole to parse symbols in .BTF_ids section in
> > > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> > > 
> > > Example of encoding:
> > > 
> > >         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
> > >         121
> > > 
> > >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
> > >         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
> > >         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> > > 
> > > This enables downstream users and tools to dynamically discover which
> > > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > > available in /sys/kernel/btf.
> > > 
> > > This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.
> > > 
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > 
> > This is great work; a lot of steps needed to collect this info, but it's
> > really valuable!
> > 
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > Tested-by: Alan Maguire <alan.maguire@oracle.com>
> > 
> > BTW we need something like the attached patch to switch to using
> > --btf_features for pahole 1.26 and later; will I send it officially or
> > do you have something that does the same that you want to roll into your
> > bpf-next series? Let me know what works from your side. Thanks!
> > 
> > > ---
> > >  btf_encoder.c | 368 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 368 insertions(+)
> > > 
> > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > index 850e36f..31848e2 100644
> > > --- a/btf_encoder.c
> > > +++ b/btf_encoder.c
> > > @@ -34,6 +34,21 @@
> > >  #include <pthread.h>
> > >  
> > >  #define BTF_ENCODER_MAX_PROTO	512
> > > +#define BTF_IDS_SECTION		".BTF_ids"
> > > +#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
> > > +#define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
> > > +#define BTF_SET8_KFUNCS		(1 << 0)
> > > +#define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
> > > +
> > > +/* Adapted from include/linux/btf_ids.h */
> > > +struct btf_id_set8 {
> > > +        uint32_t cnt;
> > > +        uint32_t flags;
> > > +        struct {
> > > +                uint32_t id;
> > > +                uint32_t flags;
> > > +        } pairs[];
> > > +};
> > >  
> > >  /* state used to do later encoding of saved functions */
> > >  struct btf_encoder_state {
> > > @@ -75,6 +90,7 @@ struct btf_encoder {
> > >  			  verbose,
> > >  			  force,
> > >  			  gen_floats,
> > > +			  skip_encoding_decl_tag,
> > >  			  tag_kfuncs,
> > >  			  is_rel;
> > >  	uint32_t	  array_index_id;
> > > @@ -94,6 +110,17 @@ struct btf_encoder {
> > >  	} functions;
> > >  };
> > >  
> > > +struct btf_func {
> > > +	const char *name;
> > > +	int	    type_id;
> > > +};
> > > +
> > > +/* Half open interval representing range of addresses containing kfuncs */
> > > +struct btf_kfunc_set_range {
> > > +	size_t start;
> > > +	size_t end;
> 
> Why size_t for addresses?

No particular reason; seemed correct to handle 64bit and 32bit. I see
uint64_t in other places. I can use that instead.

> 
> > > +};
> > > +
> > >  static LIST_HEAD(encoders);
> > >  static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
> > >  
> > > @@ -1363,8 +1390,339 @@ out:
> > >  	return err;
> > >  }
> > >  
> > > +/* Returns if `sym` points to a kfunc set */
> > > +static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
> > > +{
> > > +	void *ptr = idlist->d_buf;
> > > +	struct btf_id_set8 *set;
> > > +	bool is_set8;
> > > +	int off;
> > > +
> > > +	/* kfuncs are only found in BTF_SET8's */
> > > +	is_set8 = !strncmp(name, BTF_ID_SET8_PFX, sizeof(BTF_ID_SET8_PFX) - 1);
> > > +	if (!is_set8)
> > > +		return false;
> 
> 
> We have, as the kernel and tools/perf:
> 
> dutil.h: * strstarts - does @str start with @prefix?
> dutil.h:static inline bool strstarts(const char *str, const char *prefix)
> 
> Can you please use it?

Ack.

> 
> > > +
> > > +	off = sym->st_value - idlist_addr;
> > > +	if (off >= idlist->d_size) {
> > > +		fprintf(stderr, "%s: symbol '%s' out of bounds\n", __func__, name);
> > > +		return false;
> > > +	}
> > > +
> > > +	/* Check the set8 flags to see if it was marked as kfunc */
> > > +	set = ptr + off;
> > > +	return set->flags & BTF_SET8_KFUNCS;
> > > +}
> > > +
> > > +/*
> > > + * Parse BTF_ID symbol and return the func name.
> > > + *
> > > + * Returns:
> > > + *	Caller-owned string containing func name if successful.
> > > + *	NULL if !func or on error.
> > > + */
> > > +static char *get_func_name(const char *sym)
> > > +{
> > > +	char *func, *end;
> > > +
> > > +	if (strncmp(sym, BTF_ID_FUNC_PFX, sizeof(BTF_ID_FUNC_PFX) - 1))
> > > +		return NULL;
> 
> strstarts()
> 
> > > +	/* Strip prefix */
> > > +	func = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
> > > +	if (strlen(func) < 2) {
> > > +                free(func);
> > > +                return NULL;
> > > +        }
> 
> Can you add a comment as to why this exception? Does this limitation
> matches one in the kernel? Where?

This handles malformed input, such as "__BTF_ID__func___" (note the
trailing triple underscore). I don't believe the kernel generates such
names, but Eduard brought it up in [0] and I'd agree it'd be nice to
not read out of bounds for all input.

[0]: https://lore.kernel.org/bpf/itgzcn4cru32sk6sswbami2ojdynwyrfof3pnx5v4j3walx5oh@4qi3337fqnrz/

> 
> > > +
> > > +	/* Strip suffix */
> > > +	end = strrchr(func, '_');
> > > +	if (!end || *(end - 1) != '_') {
> > > +		free(func);
> > > +		return NULL;
> > > +	}
> > > +	*(end - 1) = '\0';
> 
> So the suffix has to have __? Can you add an example of such a func name
> as a comment above this chopping?

Sure.

> 
> > > +	return func;
> > > +}
> > > +
> > > +static int btf_func_cmp(const void *_a, const void *_b)
> > > +{
> > > +	const struct btf_func *a = _a;
> > > +	const struct btf_func *b = _b;
> > > +
> > > +	return strcmp(a->name, b->name);
> > > +}
> > > +
> > > +/*
> > > + * Collects all functions described in BTF.
> > > + * Returns non-zero on error.
> > > + */
> > > +static int btf_encoder__collect_btf_funcs(struct btf_encoder *encoder, struct gobuffer *funcs)
> > > +{
> > > +	struct btf *btf = encoder->btf;
> > > +	int nr_types, type_id;
> > > +	int err = -1;
> > > +
> > > +	/* First collect all the func entries into an array */
> > > +	nr_types = btf__type_cnt(btf);
> > > +	for (type_id = 1; type_id < nr_types; type_id++) {
> > > +		const struct btf_type *type;
> > > +		struct btf_func func = {};
> > > +		const char *name;
> > > +
> > > +		type = btf__type_by_id(btf, type_id);
> > > +		if (!type) {
> > > +			fprintf(stderr, "%s: malformed BTF, can't resolve type for ID %d\n",
> > > +				__func__, type_id);
> > > +			err = -EINVAL;
> > > +			goto out;
> > > +		}
> > > +
> > > +		if (!btf_is_func(type))
> > > +			continue;
> > > +
> > > +		name = btf__name_by_offset(btf, type->name_off);
> > > +		if (!name) {
> > > +			fprintf(stderr, "%s: malformed BTF, can't resolve name for ID %d\n",
> > > +				__func__, type_id);
> > > +			err = -EINVAL;
> > > +			goto out;
> > > +		}
> > > +
> > > +		func.name = name;
> > > +		func.type_id = type_id;
> > > +		err = gobuffer__add(funcs, &func, sizeof(func));
> > > +		if (err < 0)
> > > +			goto out;
> > > +	}
> > > +
> > > +	/* Now that we've collected funcs, sort them by name */
> > > +	qsort((void *)gobuffer__entries(funcs), gobuffer__nr_entries(funcs),
> > > +	      sizeof(struct btf_func), btf_func_cmp);
> 
> Better to introcduce a 'gobuffer__sort(funcs, sizeof(struct btf_func), btf_func_cmp)' like we
> have a gobuffer__compress(), please.

Good idea

[..]

Thanks,
Daniel
