Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC03C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578AA218D0
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiSbD69Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfB1S5z (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:57:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33775 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfB1S5y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 13:57:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id z39so24829482qtz.0;
        Thu, 28 Feb 2019 10:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zzUkxPzGuknGhllDQU+vl3itzyIELwT2c0DlTwZt2AI=;
        b=FiSbD69ZchiUjy6yglM1v8IGhbqJei/hK+rGXMJ4pgmPELvy3s36lcYqmadL1kegT2
         oiqmC4muYmoJtUa7TY4HoslrN4D2UENevotXu0De9i+vTUc38sm9dh2e4T+3sL20EJu2
         y3zdHmbjosE0EAOmtBobpeM7KiSEHUEL5apni2A+ZuYotNXwa+mD8XCD9cjYQGi9dX8W
         L+tdeQXRwhan9uu9SZWAQdRBcKa8J6JkiJm7Z7B7FZ2M4dsjOqafQDcqGUazxUdIuVd7
         HjU8uWY85x9JCo/SJ3p/dfzYHmYfL1UEC4DZdAO+TAIJbS4B3GwvlDq6n+CcIeHBBuX1
         s6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zzUkxPzGuknGhllDQU+vl3itzyIELwT2c0DlTwZt2AI=;
        b=W/IX65eAaS0kApKJ/wqb+18OL+tHtZefenbBlibDzUMAjnQEmAM4XLoz4JE7Ve306q
         hGU+JZKbUTbDRQf4BX0VNvGYpqAuWVvmGuBSw3hhoi/D6zpB9PT4k3T1BC3RZRNp84i+
         cI0+a6SAexHeEUStM7FGgrvdoM8xfXATCucR9RZApx+kh0QCqT4mUSE4JtmnqJRe70df
         e0hZJaVsVvXNQJ1nOfFP0ja65wY6+i1TiKmpVp5DwJP2CjuKzm36uFkfhTRXNRvnMEZd
         40j4aJK2M9iGxGx73TKEwRd3Dx3OSZoo3mmgVaGhd1zwrvzQw/T8npG7LJvqsiCN9YKT
         TpMA==
X-Gm-Message-State: APjAAAUrtW4Fxxam0LKeG3l9da49fe/EHZGWCyvtX6NFIoAF1SopZ6PE
        vBUrM+Nz1ar0/4g4j4+VK2AfLEe7
X-Google-Smtp-Source: APXvYqw4q+1xQwyTrgRMTAb7xQd0OHe0+ZN6zRbSVJzLOXGklNNbQSeH1xCowg8pIfaGMQMO/NjBiw==
X-Received: by 2002:ac8:587:: with SMTP id a7mr620707qth.241.1551380272833;
        Thu, 28 Feb 2019 10:57:52 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id p64sm4045360qkc.62.2019.02.28.10.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:57:51 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 89C7B4039C; Thu, 28 Feb 2019 15:57:49 -0300 (-03)
Date:   Thu, 28 Feb 2019 15:57:49 -0300
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com, ast@fb.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next 3/5] btf: allow to customize dedup hash table
 size
Message-ID: <20190228185749.GJ9508@kernel.org>
References: <20190227224642.1069138-1-andriin@fb.com>
 <20190227224642.1069138-4-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227224642.1069138-4-andriin@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 27, 2019 at 02:46:39PM -0800, Andrii Nakryiko escreveu:
> Default size of dedup table (16k) is good enough for most binaries, even
> typical vmlinux images. But there are cases of binaries with huge amount
> of BTF types (e.g., allyesconfig variants of kernel), which benefit from
> having bigger dedup table size to lower amount of unnecessary hash
> collisions. Tools like pahole, thus, can tune this parameter to reach
> optimal performance.
> 
> This change also serves double purpose of allowing tests to force hash
> collisions to test some corner cases, used in follow up patch.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/lib/bpf/btf.c | 43 ++++++++++++++++++++++++++-----------------
>  tools/lib/bpf/btf.h |  1 +
>  2 files changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 68b50e9bbde1..6bbb710216e6 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1070,8 +1070,7 @@ int btf__dedup(struct btf *btf, struct btf_ext *btf_ext,
>  	return err;
>  }
>  
> -#define BTF_DEDUP_TABLE_SIZE_LOG 14
> -#define BTF_DEDUP_TABLE_MOD ((1 << BTF_DEDUP_TABLE_SIZE_LOG) - 1)
> +#define BTF_DEDUP_TABLE_DEFAULT_SIZE (1 << 14)
>  #define BTF_UNPROCESSED_ID ((__u32)-1)
>  #define BTF_IN_PROGRESS_ID ((__u32)-2)
>  
> @@ -1128,18 +1127,21 @@ static inline __u32 hash_combine(__u32 h, __u32 value)
>  #undef GOLDEN_RATIO_PRIME
>  }
>  
> -#define for_each_hash_node(table, hash, node) \
> -	for (node = table[hash & BTF_DEDUP_TABLE_MOD]; node; node = node->next)
> +#define for_each_dedup_cand(d, hash, node) \
> +	for (node = d->dedup_table[hash & (d->opts.dedup_table_size - 1)]; \
> +	     node;							   \
> +	     node = node->next)
>  
>  static int btf_dedup_table_add(struct btf_dedup *d, __u32 hash, __u32 type_id)
>  {
>  	struct btf_dedup_node *node = malloc(sizeof(struct btf_dedup_node));
> +	int bucket = hash & (d->opts.dedup_table_size - 1);
>  
>  	if (!node)
>  		return -ENOMEM;
>  	node->type_id = type_id;
> -	node->next = d->dedup_table[hash & BTF_DEDUP_TABLE_MOD];
> -	d->dedup_table[hash & BTF_DEDUP_TABLE_MOD] = node;
> +	node->next = d->dedup_table[bucket];
> +	d->dedup_table[bucket] = node;
>  	return 0;
>  }
>  
> @@ -1177,7 +1179,7 @@ static void btf_dedup_table_free(struct btf_dedup *d)
>  	if (!d->dedup_table)
>  		return;
>  
> -	for (i = 0; i < (1 << BTF_DEDUP_TABLE_SIZE_LOG); i++) {
> +	for (i = 0; i < d->opts.dedup_table_size; i++) {
>  		while (d->dedup_table[i]) {
>  			tmp = d->dedup_table[i];
>  			d->dedup_table[i] = tmp->next;
> @@ -1221,10 +1223,19 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, struct btf_ext *btf_ext,
>  	if (!d)
>  		return ERR_PTR(-ENOMEM);
>  
> +	d->opts.dont_resolve_fwds = opts && opts->dont_resolve_fwds;

Is the above line a leftover from some other patch? Doesn't seem related
to this patch.

The rest seems ok.

> +	/* ensure table size is power of two and limit to 2G */
> +	d->opts.dedup_table_size = opts && opts->dedup_table_size
> +		? opts->dedup_table_size
> +		: BTF_DEDUP_TABLE_DEFAULT_SIZE;
> +	for (i = 0; i < 31 && (1 << i) < d->opts.dedup_table_size;  i++)
> +		;
> +	d->opts.dedup_table_size = 1 << i;
> +
>  	d->btf = btf;
>  	d->btf_ext = btf_ext;
>  
> -	d->dedup_table = calloc(1 << BTF_DEDUP_TABLE_SIZE_LOG,
> +	d->dedup_table = calloc(d->opts.dedup_table_size,
>  				sizeof(struct btf_dedup_node *));
>  	if (!d->dedup_table) {
>  		err = -ENOMEM;
> @@ -1249,8 +1260,6 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, struct btf_ext *btf_ext,
>  	for (i = 0; i <= btf->nr_types; i++)
>  		d->hypot_map[i] = BTF_UNPROCESSED_ID;
>  
> -	d->opts.dont_resolve_fwds = opts && opts->dont_resolve_fwds;
> -
>  done:
>  	if (err) {
>  		btf_dedup_free(d);
> @@ -1824,7 +1833,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
>  
>  	case BTF_KIND_INT:
>  		h = btf_hash_int(t);
> -		for_each_hash_node(d->dedup_table, h, cand_node) {
> +		for_each_dedup_cand(d, h, cand_node) {
>  			cand = d->btf->types[cand_node->type_id];
>  			if (btf_equal_int(t, cand)) {
>  				new_id = cand_node->type_id;
> @@ -1835,7 +1844,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
>  
>  	case BTF_KIND_ENUM:
>  		h = btf_hash_enum(t);
> -		for_each_hash_node(d->dedup_table, h, cand_node) {
> +		for_each_dedup_cand(d, h, cand_node) {
>  			cand = d->btf->types[cand_node->type_id];
>  			if (btf_equal_enum(t, cand)) {
>  				new_id = cand_node->type_id;
> @@ -1846,7 +1855,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
>  
>  	case BTF_KIND_FWD:
>  		h = btf_hash_common(t);
> -		for_each_hash_node(d->dedup_table, h, cand_node) {
> +		for_each_dedup_cand(d, h, cand_node) {
>  			cand = d->btf->types[cand_node->type_id];
>  			if (btf_equal_common(t, cand)) {
>  				new_id = cand_node->type_id;
> @@ -2263,7 +2272,7 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
>  		return 0;
>  
>  	h = btf_hash_struct(t);
> -	for_each_hash_node(d->dedup_table, h, cand_node) {
> +	for_each_dedup_cand(d, h, cand_node) {
>  		int eq;
>  
>  		btf_dedup_clear_hypot_map(d);
> @@ -2349,7 +2358,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
>  		t->type = ref_type_id;
>  
>  		h = btf_hash_common(t);
> -		for_each_hash_node(d->dedup_table, h, cand_node) {
> +		for_each_dedup_cand(d, h, cand_node) {
>  			cand = d->btf->types[cand_node->type_id];
>  			if (btf_equal_common(t, cand)) {
>  				new_id = cand_node->type_id;
> @@ -2372,7 +2381,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
>  		info->index_type = ref_type_id;
>  
>  		h = btf_hash_array(t);
> -		for_each_hash_node(d->dedup_table, h, cand_node) {
> +		for_each_dedup_cand(d, h, cand_node) {
>  			cand = d->btf->types[cand_node->type_id];
>  			if (btf_equal_array(t, cand)) {
>  				new_id = cand_node->type_id;
> @@ -2403,7 +2412,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
>  		}
>  
>  		h = btf_hash_fnproto(t);
> -		for_each_hash_node(d->dedup_table, h, cand_node) {
> +		for_each_dedup_cand(d, h, cand_node) {
>  			cand = d->btf->types[cand_node->type_id];
>  			if (btf_equal_fnproto(t, cand)) {
>  				new_id = cand_node->type_id;
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index b60bb7cf5fff..28a1e1e59861 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -90,6 +90,7 @@ LIBBPF_API __u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_ext);
>  LIBBPF_API __u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext);
>  
>  struct btf_dedup_opts {
> +	unsigned int dedup_table_size;
>  	bool dont_resolve_fwds;
>  };
>  
> -- 
> 2.17.1

-- 

- Arnaldo
