Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F543451C1
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770895707; cv=none; b=c7VqocQExGxpfhFNhtbhZPst8EtD3JvetU3ofEmlXMOGC6DWBBLrGZaKvsZYhyelEIjk5wREQqWlJBw0USqaJubMW60nhEfituhpa1ZhVXbBUP/23Y1kznSkjVLFWP0XdE1YfZ/6n49NF0OAmR5uh9CL4TeOdhRz4qr/yxXVpLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770895707; c=relaxed/simple;
	bh=6yVM9SiWfy/Pz5Loh4jYK9/SA/i7ckElhLlWUZY8g28=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOCvffmVLOLhmGSJ8rE4YXd5mRGhZfeVoDbvMEgarqkql66EhvKlp5FQWGdqsJb8lLzV3xDyPv94am0RecfN7DkRHayZQLHjfHqs1mZMu5lxJvdl9sUlHJyKE+J5IISGT3oMthF9eL9JvkmmEG4APlrw0ketEfPlgNJq+QBslfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2qgRfzk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2qgRfzk"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso28455785e9.1
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 03:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770895705; x=1771500505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AkGGtyBqaY/191+Nt84O9NdajNDK37eJ53SPdynxQao=;
        b=c2qgRfzkrgjx03MAJSlcY4L9G1+iLSTX6vtviKEn41qXnct3v9hhRst4b25T+l0U1c
         7+vXdrj7Xj5AblhSnmJFfYlCOfq0Jt6XiPdDoBu6LDY7pcqCYL5ubOnla4zjr0+YxvIj
         35rHpvT+LObuVC6xJrovLQJGkuTr5m82N3aXsx9X+aiVxxDU+rTzvUdJt3o/abdX28dA
         HEQkgb3wKunauPWSrPXrDD1HuTROBg7ouf56okN5TjXVGel67t6IM0v979ECuND85DHB
         0ixvRZUoWZkZJp3965ynm04Xg719jfcOSfTJ0SYYBLk/DhcECFGASKSdYI2Tu41Toz2c
         F79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770895705; x=1771500505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkGGtyBqaY/191+Nt84O9NdajNDK37eJ53SPdynxQao=;
        b=dSwSttH8nkI2da0vtwFbmb6OxGLlYj435Tr0gJ/6V2X/FpLHvZpdIp1s1LETVEgZyA
         amXFPoDXM+f7Tyje/Yf1VmKORw++LNZQQjWW9rEzkUcT3VbDOiI3Nyp1pwWi7B/O2Jc1
         z0HYe57zAoHxqw6uQ4xtzSycypw4GX6WI+w4Bzgb5UOowopQgHj7NmUMw6gFPAU9q5Xj
         bwtKkI5YSV6LftDBQphjOqFvTtIGDR0WXrBeiVSm1bkj/8c9/e+qx2891BHW446IkE4I
         LbGc6S2nhUe6s76P8sB3772aqDFVZ3YvlN6PmLK8yE3S/SWYvJke78ktkCKwj2Rl58EA
         eJig==
X-Forwarded-Encrypted: i=1; AJvYcCUxMbO1tsxsq+X1VcYNzH27KLFAlVx6aldXLzxPSDWowSk/ZZE9u6jpsspOxASe9xVVS6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD94OpK77Ffc4eCHVpDhcMriFdGAQd1U9SIO2xiaeisHpmintl
	GF7pFr33biXrnP/HBYzp2oQocRtg3E3P+BVNvPKq23s3HLra0IpANmJw
X-Gm-Gg: AZuq6aJdU3CfUlT1QRODQeNy3CBwuxwDMBvqE8kHRG4atDpFWn62RgLVwhqymycm6dG
	myE3b5SVXgkwCpcJtxk4Jc4Bdyq3C+8MB/jnWGMBu6cGD14/q7e0L/KDOG2puPuEbIHe+ZBVJDw
	8UnXGIgOxirfG+sGiRWN6n3oaBHx4vtvIWDd/Br1aHqSTa6llq5Jzv8B6DFPRs9EABGx9LXO//L
	zhBX2c1eqPmC+TJe/ii1QH/JrjnGkwH/bX+mrRyIv2SL6rr6tJj4h1lCNI3SHTcIlSWeaqZr5z4
	mTWQO7n89inLfBuNV/jH5d98n/WJBAUXais4Cn68l1ANx/3CsUEEE9XBynANavnHXdz7dLF3sao
	9pRTbGBhgLjr7p0lPD/3LYNg8PuepxcsWnMp+nnxdVjaGb5PA5UvdET6XpyrjUJ+yeeftYyrk
X-Received: by 2002:a05:600d:6401:20b0:483:6a8d:b2fc with SMTP id 5b1f17b1804b1-4836a8db4d8mr17421205e9.8.1770895704339;
        Thu, 12 Feb 2026 03:28:24 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dd20519sm188751845e9.15.2026.02.12.03.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 03:28:23 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Feb 2026 12:28:21 +0100
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 02/14] resolve_btfids: Fix memory leaks
 reported by ASAN
Message-ID: <aY25VcBtWd3O7-Gp@krava>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <20260212011356.3266753-3-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212011356.3266753-3-ihor.solodrai@linux.dev>

On Wed, Feb 11, 2026 at 05:13:44PM -0800, Ihor Solodrai wrote:
> Running resolve_btfids with ASAN reveals memory leaks in btf_id
> handling.
> 
> - Change get_id() to use a local buffer
> - Make btf_id__add() strdup the name internally
> - Add btf_id__free_all() that frees all nodese of a tree
> - Call the cleanup function on exit for every tree
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

one nit below

thanks,
jirka


> ---
>  tools/bpf/resolve_btfids/main.c | 78 +++++++++++++++++++++------------
>  1 file changed, 51 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index ca7fcd03efb6..863fa0faaa31 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -226,7 +226,7 @@ static struct btf_id *btf_id__find(struct rb_root *root, const char *name)
>  }
>  
>  static struct btf_id *__btf_id__add(struct rb_root *root,
> -				    char *name,
> +				    const char *name,
>  				    enum btf_id_kind kind,
>  				    bool unique)
>  {
> @@ -250,7 +250,11 @@ static struct btf_id *__btf_id__add(struct rb_root *root,
>  	id = zalloc(sizeof(*id));
>  	if (id) {
>  		pr_debug("adding symbol %s\n", name);
> -		id->name = name;
> +		id->name = strdup(name);
> +		if (!id->name) {
> +			free(id);
> +			return NULL;
> +		}
>  		id->kind = kind;
>  		rb_link_node(&id->rb_node, parent, p);
>  		rb_insert_color(&id->rb_node, root);
> @@ -258,17 +262,17 @@ static struct btf_id *__btf_id__add(struct rb_root *root,
>  	return id;
>  }
>  
> -static inline struct btf_id *btf_id__add(struct rb_root *root, char *name, enum btf_id_kind kind)
> +static inline struct btf_id *btf_id__add(struct rb_root *root, const char *name, enum btf_id_kind kind)
>  {
>  	return __btf_id__add(root, name, kind, false);
>  }
>  
> -static inline struct btf_id *btf_id__add_unique(struct rb_root *root, char *name, enum btf_id_kind kind)
> +static inline struct btf_id *btf_id__add_unique(struct rb_root *root, const char *name, enum btf_id_kind kind)
>  {
>  	return __btf_id__add(root, name, kind, true);
>  }
>  
> -static char *get_id(const char *prefix_end)
> +static int get_id(const char *prefix_end, char *buf, size_t buf_sz)
>  {
>  	/*
>  	 * __BTF_ID__func__vfs_truncate__0
> @@ -277,28 +281,28 @@ static char *get_id(const char *prefix_end)
>  	 */
>  	int len = strlen(prefix_end);
>  	int pos = sizeof("__") - 1;
> -	char *p, *id;
> +	char *p;
>  
>  	if (pos >= len)
> -		return NULL;
> +		return -1;
>  
> -	id = strdup(prefix_end + pos);
> -	if (id) {
> -		/*
> -		 * __BTF_ID__func__vfs_truncate__0
> -		 * id =            ^
> -		 *
> -		 * cut the unique id part
> -		 */
> -		p = strrchr(id, '_');
> -		p--;
> -		if (*p != '_') {
> -			free(id);
> -			return NULL;
> -		}
> -		*p = '\0';
> -	}
> -	return id;
> +	if (len - pos >= buf_sz)
> +		return -1;
> +
> +	strcpy(buf, prefix_end + pos);
> +	/*
> +	 * __BTF_ID__func__vfs_truncate__0
> +	 * buf =           ^
> +	 *
> +	 * cut the unique id part
> +	 */
> +	p = strrchr(buf, '_');
> +	p--;
> +	if (*p != '_')
> +		return -1;
> +	*p = '\0';
> +
> +	return 0;
>  }
>  
>  static struct btf_id *add_set(struct object *obj, char *name, enum btf_id_kind kind)
> @@ -335,10 +339,9 @@ static struct btf_id *add_set(struct object *obj, char *name, enum btf_id_kind k
>  
>  static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
>  {
> -	char *id;
> +	char id[KSYM_NAME_LEN];
>  
> -	id = get_id(name + size);
> -	if (!id) {
> +	if (get_id(name + size, id, sizeof(id))) {
>  		pr_err("FAILED to parse symbol name: %s\n", name);
>  		return NULL;
>  	}
> @@ -346,6 +349,22 @@ static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
>  	return btf_id__add(root, id, BTF_ID_KIND_SYM);
>  }
>  
> +static void btf_id__free_all(struct rb_root *root)
> +{
> +	struct rb_node *node, *next;
> +	struct btf_id *id;
> +
> +	node = rb_first(root);
> +	while (node) {
> +		next = rb_next(node);
> +		id = rb_entry(node, struct btf_id, rb_node);
> +		rb_erase(node, root);
> +		free(id->name);
> +		free(id);
> +		node = next;
> +	}
> +}


nit, I think we could do it with just single rb_node pointer, like:

        next = rb_first(root);
        while (next) {
                id = rb_entry(next, struct btf_id, rb_node);
                next = rb_next(&id->rb_node);
                rb_erase(&id->rb_node, root);
                free(id->name);
                free(id);
        }

jirka

> +
>  static void bswap_32_data(void *data, u32 nr_bytes)
>  {
>  	u32 cnt, i;
> @@ -1547,6 +1566,11 @@ int main(int argc, const char **argv)
>  out:
>  	btf__free(obj.base_btf);
>  	btf__free(obj.btf);
> +	btf_id__free_all(&obj.structs);
> +	btf_id__free_all(&obj.unions);
> +	btf_id__free_all(&obj.typedefs);
> +	btf_id__free_all(&obj.funcs);
> +	btf_id__free_all(&obj.sets);
>  	if (obj.efile.elf) {
>  		elf_end(obj.efile.elf);
>  		close(obj.efile.fd);
> -- 
> 2.53.0
> 
> 
