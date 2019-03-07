Return-Path: <SRS0=xp9Q=RK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC11C43381
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 14:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3302E2083D
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 14:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/cWRyxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCGOJX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:09:23 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37211 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGOJW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Mar 2019 09:09:22 -0500
Received: by mail-qt1-f194.google.com with SMTP id a48so17168216qtb.4;
        Thu, 07 Mar 2019 06:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YCJXTdzIgwzQ44I/6Gqfpm69gNPfg2puY3SD/FwwGlY=;
        b=C/cWRyxLMtzN1MWRfRKstgSqJJzXcccvpmfQwDkCHNvM3UYlYervUytUWeM8pZ7nYP
         PfF7MxUK770AyWDGAyWjRMM16rx6eY6r7swyz4pgPd/1iRaPdF1AegynVjYMJM7rV/MT
         qXTHpr3VkDeqI72RKefuAw6W4V2JyVxoLt+ZkK/tRKQTZ8cQ81YAe/+qxOqI1A+L9SjL
         6DwN9EEBTVXUYebPMvc6qyLq170pzjelrDW+ZCmUP09iAkjI8KqsQYDEmzfFYpxhtsWt
         LgF23IRaTIYpV8QhxwY2QJhgwX4/eDbUNlphQrG4w8Ns486cUf+xr9RYQxhC3ip8qKFM
         MX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YCJXTdzIgwzQ44I/6Gqfpm69gNPfg2puY3SD/FwwGlY=;
        b=lg6fXfqdmmDDns5K4GcUI/Bzzc5Ina1zzmlgs/gD0bJGTOY82M9XNMDPIdQyYTspWm
         GvXeOgFqpaR/tp9GbH9FjbeYREXx+dwBAj9tSXN+pr0MOoersB2xSK5IxlHB4N6+sXT/
         +YKqIKTRWV26weadMkh6U8B9CFuatz7iOX32X+hM/LYX1xv02+/llFkOSuJY+i7LNUlP
         bS0cuW+qdsWbQ9y1BQbVnSs2mE5oq4V1uXjvS4vLPPU4EOmCBmT/oZOJfM6v6ATFJhZ5
         2+soNOXmL2bu8j+9IWD3RSQwX3pbTFTf7ZilbXSXRvFlDXxSWCMzjb7BpfxV1vW8Ujfe
         1y3Q==
X-Gm-Message-State: APjAAAVuTgoeEo6BXNI3gm1tWIkTiPcN8vJCIhoPWfM11AjlYNIfNN0I
        SZsT9gIfzXnvacootG5uCMU=
X-Google-Smtp-Source: APXvYqziJWsjfehZ60eQJpvXczZva6XktIPyB9iNFQ2Grr3pKpm1MNvpYe2/7Bo5C3tHE7ppZLlrRQ==
X-Received: by 2002:ac8:2766:: with SMTP id h35mr10328320qth.148.1551967760938;
        Thu, 07 Mar 2019 06:09:20 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id v131sm2484356qka.95.2019.03.07.06.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 06:09:20 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3AF424039C; Thu,  7 Mar 2019 11:09:17 -0300 (-03)
Date:   Thu, 7 Mar 2019 11:09:17 -0300
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     arnaldo.melo@gmail.com, andrii.nakryiko@gmail.com, ast@fb.com,
        yhs@fb.com, dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH pahole] pahole: use 32-bit integers for iterations within
 CU
Message-ID: <20190307140917.GW13100@kernel.org>
References: <20190307002321.4071708-1-andriin@fb.com>
 <20190307140247.GV13100@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307140247.GV13100@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Mar 07, 2019 at 11:02:47AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Mar 06, 2019 at 04:23:21PM -0800, Andrii Nakryiko escreveu:
> > Due to this assumption, libdwarves and other parts of pahole are using 16-bit
> > counters to iterate over entities within CU. This can cause infinite loop when
> > iterating BTF data, if there are more than 65535 types. This patch changes
> > non-public variables to use 32-bit integers, where appropriate.
 
> Ok, there are some bits that are unrelated, I'm comment on it and remove
> before applying.

Ooops, see below, I'm removing the non-type related parts, and will look
at changing the types till btfdiff with that allyesconfig aarch64
vmlinux image shows no diffs.

- Arnaldo
  
> - Arnaldo
>  
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >  btf_loader.c      |  4 ++--
> >  dwarves.c         | 16 ++++++++--------
> >  dwarves_fprintf.c |  8 ++++----
> >  pahole.c          | 36 ++++++++++++++++++------------------
> >  4 files changed, 32 insertions(+), 32 deletions(-)
> > 
> > diff --git a/btf_loader.c b/btf_loader.c
> > index 867c608..3de774a 100644
> > --- a/btf_loader.c
> > +++ b/btf_loader.c
> > @@ -45,7 +45,7 @@ static void *tag__alloc(const size_t size)
> >  	return tag;
> >  }
> >  
> > -static int btf_elf__load_ftype(struct btf_elf *btfe, struct ftype *proto, uint16_t tag,
> > +static int btf_elf__load_ftype(struct btf_elf *btfe, struct ftype *proto, uint32_t tag,
> >  			       uint32_t type, uint16_t vlen, struct btf_param *args, long id)
> >  {
> >  	int i;
> > @@ -100,7 +100,7 @@ static struct base_type *base_type__new(strings_t name, uint32_t attrs,
> >  	return bt;
> >  }
> >  
> > -static void type__init(struct type *type, uint16_t tag,
> > +static void type__init(struct type *type, uint32_t tag,
> >  		       strings_t name, size_t size)
> >  {
> >  	INIT_LIST_HEAD(&type->node);
> > diff --git a/dwarves.c b/dwarves.c
> > index 111797b..3594ae3 100644
> > --- a/dwarves.c
> > +++ b/dwarves.c
> > @@ -349,7 +349,7 @@ reevaluate:
> >  
> >  static void cu__find_class_holes(struct cu *cu)
> >  {
> > -	uint16_t id;
> > +	uint32_t id;
> >  	struct class *pos;
> >  
> >  	cu__for_each_struct(cu, id, pos)
> > @@ -566,7 +566,7 @@ struct tag *cu__type(const struct cu *cu, const uint16_t id)
> >  struct tag *cu__find_first_typedef_of_type(const struct cu *cu,
> >  					   const uint16_t type)
> >  {
> > -	uint16_t id;
> > +	uint32_t id;
> >  	struct tag *pos;
> >  
> >  	if (cu == NULL || type == 0)
> > @@ -582,7 +582,7 @@ struct tag *cu__find_first_typedef_of_type(const struct cu *cu,
> >  struct tag *cu__find_base_type_by_name(const struct cu *cu,
> >  				       const char *name, uint16_t *idp)
> >  {
> > -	uint16_t id;
> > +	uint32_t id;
> >  	struct tag *pos;
> >  
> >  	if (cu == NULL || name == NULL)
> > @@ -611,7 +611,7 @@ struct tag *cu__find_base_type_by_sname_and_size(const struct cu *cu,
> >  						 uint16_t bit_size,
> >  						 uint16_t *idp)
> >  {
> > -	uint16_t id;
> > +	uint32_t id;
> >  	struct tag *pos;
> >  
> >  	if (sname == 0)
> > @@ -638,7 +638,7 @@ struct tag *cu__find_enumeration_by_sname_and_size(const struct cu *cu,
> >  						   uint16_t bit_size,
> >  						   uint16_t *idp)
> >  {
> > -	uint16_t id;
> > +	uint32_t id;
> >  	struct tag *pos;
> >  
> >  	if (sname == 0)
> > @@ -663,7 +663,7 @@ struct tag *cu__find_enumeration_by_sname_and_size(const struct cu *cu,
> >  struct tag *cu__find_struct_by_sname(const struct cu *cu, strings_t sname,
> >  				     const int include_decls, uint16_t *idp)
> >  {
> > -	uint16_t id;
> > +	uint32_t id;
> >  	struct tag *pos;
> >  
> >  	if (sname == 0)
> > @@ -699,7 +699,7 @@ static struct tag *__cu__find_struct_by_name(const struct cu *cu, const char *na
> >  	if (cu == NULL || name == NULL)
> >  		return NULL;
> >  
> > -	uint16_t id;
> > +	uint32_t id;
> >  	struct tag *pos;
> >  	cu__for_each_type(cu, id, pos) {
> >  		struct type *type;
> > @@ -1128,7 +1128,7 @@ void lexblock__add_label(struct lexblock *block, struct label *label)
> >  }
> >  
> >  const struct class_member *class__find_bit_hole(const struct class *class,
> > -					    const struct class_member *trailer,
> > +						const struct class_member *trailer,

This one is unrelated, so I'll remove from this patch.

> >  						const uint16_t bit_hole_size)
> >  {
> >  	struct class_member *pos;
> > diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> > index 490dc30..530c27b 100644
> > --- a/dwarves_fprintf.c
> > +++ b/dwarves_fprintf.c
> > @@ -163,7 +163,7 @@ static const char *tag__accessibility(const struct tag *tag)
> >  	return NULL;
> >  }
> >  
> > -static size_t __tag__id_not_found_snprintf(char *bf, size_t len, uint16_t id,
> > +static size_t __tag__id_not_found_snprintf(char *bf, size_t len, uint32_t id,
> >  					   const char *fn, int line)
> >  {
> >  	return snprintf(bf, len, "<ERROR(%s:%d): %#llx not found!>", fn, line,
> > @@ -425,7 +425,7 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
> >  		return tag__ptr_name(tag, cu, bf, len, "&");
> >  	case DW_TAG_ptr_to_member_type: {
> >  		char suffix[512];
> > -		uint16_t id = tag__ptr_to_member_type(tag)->containing_type;
> > +		uint32_t id = tag__ptr_to_member_type(tag)->containing_type;

Not strictly need as we haven't changed ptr_to_member_type's 'containing_type'
to uint32_t, it remains uint16_t as it is part of the ABI, right?
 
> >  		type = cu__type(cu, id);
> >  		if (type != NULL)
> > @@ -1213,7 +1213,7 @@ static size_t __class__fprintf(struct class *class, const struct cu *cu,
> >  	struct type *type = &class->type;
> >  	size_t last_size = 0, size;
> >  	uint8_t newline = 0;
> > -	uint16_t nr_paddings = 0;
> > +	uint32_t nr_paddings = 0;

No need to convert this one as this is not a type id?

> >  	uint32_t sum = 0;
> >  	uint32_t sum_holes = 0;
> >  	uint32_t sum_paddings = 0;
> > @@ -1225,7 +1225,7 @@ static size_t __class__fprintf(struct class *class, const struct cu *cu,
> >  	struct tag *tag_pos;
> >  	const char *current_accessibility = NULL;
> >  	struct conf_fprintf cconf = conf ? *conf : conf_fprintf__defaults;
> > -	const uint16_t t = type->namespace.tag.tag;
> > +	const uint32_t t = type->namespace.tag.tag;

Ditto

> >  	size_t printed = fprintf(fp, "%s%s%s%s%s",
> >  				 cconf.prefix ?: "", cconf.prefix ? " " : "",
> >  				 ((cconf.classes_as_structs ||
> > diff --git a/pahole.c b/pahole.c
> > index 2230e37..bec279c 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -41,9 +41,9 @@ static size_t cu__exclude_prefix_len;
> >  static char *decl_exclude_prefix;
> >  static size_t decl_exclude_prefix_len;
> >  
> > -static uint16_t nr_holes;
> > -static uint16_t nr_bit_holes;
> > -static uint16_t hole_size_ge;
> > +static uint32_t nr_holes;
> > +static uint32_t nr_bit_holes;
> > +static uint32_t hole_size_ge;

Ditto for these 3

> >  static uint8_t show_packable;
> >  static uint8_t global_verbose;
> >  static uint8_t recursive;
> > @@ -156,7 +156,7 @@ static void nr_definitions_formatter(struct structure *st)
> >  }
> >  
> >  static void nr_members_formatter(struct class *class,
> > -				 struct cu *cu, uint16_t id __unused)
> > +				 struct cu *cu, uint32_t id __unused)
> >  {
> >  	printf("%s%c%u\n", class__name(class, cu), separator,
> >  	       class__nr_members(class));
> > @@ -168,26 +168,26 @@ static void nr_methods_formatter(struct structure *st)
> >  }
> >  
> >  static void size_formatter(struct class *class,
> > -			   struct cu *cu, uint16_t id __unused)
> > +			   struct cu *cu, uint32_t id __unused)
> >  {
> >  	printf("%s%c%d%c%u\n", class__name(class, cu), separator,
> >  	       class__size(class), separator, class->nr_holes);
> >  }
> >  
> >  static void class_name_len_formatter(struct class *class, struct cu *cu,
> > -				     uint16_t id __unused)
> > +				     uint32_t id __unused)
> >  {
> >  	const char *name = class__name(class, cu);
> >  	printf("%s%c%zd\n", name, separator, strlen(name));
> >  }
> >  
> >  static void class_name_formatter(struct class *class,
> > -				 struct cu *cu, uint16_t id __unused)
> > +				 struct cu *cu, uint32_t id __unused)
> >  {
> >  	puts(class__name(class, cu));
> >  }
> >  
> > -static void class_formatter(struct class *class, struct cu *cu, uint16_t id)
> > +static void class_formatter(struct class *class, struct cu *cu, uint32_t id)
> >  {
> >  	struct tag *typedef_alias = NULL;
> >  	struct tag *tag = class__tag(class);
> > @@ -224,7 +224,7 @@ static void class_formatter(struct class *class, struct cu *cu, uint16_t id)
> >  	putchar('\n');
> >  }
> >  
> > -static void print_packable_info(struct class *c, struct cu *cu, uint16_t id)
> > +static void print_packable_info(struct class *c, struct cu *cu, uint32_t id)
> >  {
> >  	const struct tag *t = class__tag(c);
> >  	const size_t orig_size = class__size(c);
> > @@ -267,14 +267,14 @@ static void print_stats(void)
> >  }
> >  
> >  static struct class *class__filter(struct class *class, struct cu *cu,
> > -				   uint16_t tag_id);
> > +				   uint32_t tag_id);
> >  
> >  static void (*formatter)(struct class *class,
> > -			 struct cu *cu, uint16_t id) = class_formatter;
> > +			 struct cu *cu, uint32_t id) = class_formatter;
> >  
> >  static void print_classes(struct cu *cu)
> >  {
> > -	uint16_t id;
> > +	uint32_t id;
> >  	struct class *pos;
> >  
> >  	cu__for_each_struct_or_union(cu, id, pos) {
> > @@ -352,7 +352,7 @@ static int class__packable(struct class *class, struct cu *cu)
> >  }
> >  
> >  static struct class *class__filter(struct class *class, struct cu *cu,
> > -				   uint16_t tag_id)
> > +				   uint32_t tag_id)
> >  {
> >  	struct tag *tag = class__tag(class);
> >  	const char *name;
> > @@ -608,7 +608,7 @@ static void cu_fixup_word_size_iterator(struct cu *cu)
> >  	original_word_size = cu->addr_size;
> >  	cu->addr_size = word_size;
> >  
> > -	uint16_t id;
> > +	uint32_t id;
> >  	struct tag *pos;
> >  	cu__for_each_type(cu, id, pos)
> >  		tag__fixup_word_size(pos, cu);
> > @@ -659,11 +659,11 @@ static void cu__account_nr_methods(struct cu *cu)
> >  
> >  static char tab[128];
> >  
> > -static void print_structs_with_pointer_to(const struct cu *cu, uint16_t type)
> > +static void print_structs_with_pointer_to(const struct cu *cu, uint32_t type)
> >  {
> >  	struct class *pos;
> >  	struct class_member *pos_member;
> > -	uint16_t id;
> > +	uint32_t id;
> >  
> >  	cu__for_each_struct(cu, id, pos) {
> >  		bool looked = false;
> > @@ -702,10 +702,10 @@ static void print_structs_with_pointer_to(const struct cu *cu, uint16_t type)
> >  	}
> >  }
> >  
> > -static void print_containers(const struct cu *cu, uint16_t type, int ident)
> > +static void print_containers(const struct cu *cu, uint32_t type, int ident)
> >  {
> >  	struct class *pos;
> > -	uint16_t id;
> > +	uint32_t id;
> >  
> >  	cu__for_each_struct(cu, id, pos) {
> >  		if (pos->type.namespace.name == 0)
> > -- 
> > 2.17.1
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
