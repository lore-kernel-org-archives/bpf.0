Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ABE3876C6
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770016; cv=none; b=B2N3YPlZzQ41ZWhrYE+spsPjNKFr5s5wtM8CNrELBgCS5PgSuXZ8bm1lX2HmvitxuNOxKfbL6MHvijzZ2WYLXBoUlIpwS3mO6pgNFNm1ZJ1vvE/6WX4teldhR8bimBGY1drQnqeg1lt4Jfk/pVGtBv3KvXWJuw4VJ5MKTKmmo5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770016; c=relaxed/simple;
	bh=9mdlkxwdZjEOHmJvvpfL3PKJe9OSUkKY33Nr2dO+2/o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4V66uQfJExrKb+t79WfwVgAg8ROy2Ptqn0So78paWmdXcP1TYQuQsx6NJZ3I2jAbZ275rW8XIfLgyddMu/M3qDXpnxgXP1bEFjGIW5yrwoXqpcFx5Jk+lhjIKUwpwoiaVeMjYzLr+v/IP2jmF2vxzq/qvRwOKB5egMVKV+6aFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmPLGbUk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmPLGbUk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso36691685e9.1
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788770013; x=1789374813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YcTehUYtqXjZzp4mhavDpXcC1OXdWaIc6/F+I9cSKmc=;
        b=OmPLGbUkUAQuJEKV/qhKlRKSsvp0EplD81A6PoZsHJOw06ZJ1C7TCCl32MtW7LGO1/
         pMHKEdUHaW6oZ6qqpfpc9kUpW4fWPsddMLx6wqREj533IFBwnRltd+hZNJP83nzv8HCF
         iUVOJlizqQ8+7kKRJouM8rqtaCEw2sdSIKnMrSy6NFUHv/ZXNsekNxGMB0ECicFK//aV
         DFRRYGsHNULlCX/ir1BO4qsoS9mcwH9tb3cCzyrezMWWRrdPp0pznvsBGsZpew1EEq7f
         RS01mPjb236B31LGt8bOQdjRpwkGia81X/bTGnwwtZ57KJH8fCWWY07+G/y7C5VY4jjg
         98aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788770013; x=1789374813;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YcTehUYtqXjZzp4mhavDpXcC1OXdWaIc6/F+I9cSKmc=;
        b=IF/gw/OK/MenBW7iFKxGKobzIk60ro69bfdTsxLZ2C/a68ACJy8sqCJQtDAHbmgq3d
         SRy1FeaK8IvE84P1JURuPW5CErnF18ZcYkqKyYc2w+9Jjmx2ZtjBLqXcuNOSf6bQ9GR/
         U3LSLL7pqb/mmPlIdhro0c5Qs2xUfPIY77RHojmtzF2wpT6NAHYn6xjk2wOqQWADNu+V
         DCyH9JWcWDOvjMQw05VGwvUhKBccqjnHUyE2IcfaLnA4ETfRGoOCDAtInupYqiHQeMjT
         gE5XeEypzL4Z0k59jYanamRCc1spzWn/MUiuJqqqwaSPQxVP4aqUMmLBjpruEWM5J8A9
         MPog==
X-Gm-Message-State: AFuF++kI2c6cjMw0lQY8Tj6Kj9YHVU35B3sYs/6F6TIIzp5+lToG65jo
	0Ig/SkgyYGG6WmDltrGuDmfXrlcvvfRJ57eT+wspBfq4B6RnLQ+/+bdg
X-Gm-Gg: AYBFou2WBDdRC0+Py4mCHhyFKNHUQ/P15uDGt+J1oCMYnmDG7Zm8FoLsRtgvlUIvr8W
	IuXsoeWbKwDCKoxA5mnqA3c5kCf+pNnkpy4LO3lg6bU54M0mNx0wXgP7WlENjvVoROF1E/uEVuG
	DISyKuBXIdQ7lDQv6r9zo9vhSWL0UUzv+/JYa3vFVftc2ksFf8TsFmPfWGBfC2qijjnMzUQ/PEd
	t10asADZBipkuRsFXFjCHSmNlW/Y7zRtJi91Ml7MrVx/6+a637hBLdgftcx6uPRt0zzCIeg0isE
	qDcByH//zINcipb9rwV+eB/VIplSQnXQlGBoZ29s57gdTzMLwnxw6JPtaG15Ie2N5OLIP6z95Fh
	RE6SP2FVp1vRwgtGU5RrqGNuMLM14KjPH5h39TCHNGHNXkcYBkTOx+AzXPqXsE+V3xr//CIelpc
	OT1uwJESCEo3YAH8AVIDJC26Y3kdU6kdco4Q==
X-Received: by 2002:a05:600c:3551:b0:49d:16df:8521 with SMTP id 5b1f17b1804b1-49d16df85a8mr1718085e9.4.1788770012885;
        Mon, 07 Sep 2026 01:33:32 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d057f4778sm190325045e9.8.2026.09.07.01.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:33:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 7 Sep 2026 10:33:30 +0200
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v7 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
Message-ID: <ap522nLwOCK-BFJo@krava>
References: <20260907053847.1115-1-zhaofuyu@vivo.com>
 <20260907053847.1115-2-zhaofuyu@vivo.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907053847.1115-2-zhaofuyu@vivo.com>

On Mon, Sep 07, 2026 at 01:38:46PM +0800, Fuyu Zhao wrote:

SNIP

>  static int load_module_btfs(struct bpf_object *obj)
>  {
>  	struct bpf_btf_info info;
> @@ -5825,6 +5842,9 @@ static int load_module_btfs(struct bpf_object *obj)
>  	if (!kernel_supports(obj, FEAT_MODULE_BTF))
>  		return 0;
>  
> +	if (obj->btf_module_allowlist_cnt == 0)
> +		return 0;
> +
>  	while (true) {
>  		err = bpf_btf_get_next_id(id, &id);
>  		if (err && errno == ENOENT)
> @@ -5867,6 +5887,11 @@ static int load_module_btfs(struct bpf_object *obj)
>  			continue;
>  		}
>  
> +		if (!is_btf_mod_allowed(obj, name)) {
> +			close(fd);
> +			continue;
> +		}
> +
>  		btf = btf_get_from_fd(fd, obj->btf_vmlinux);
>  		err = libbpf_get_error(btf);
>  		if (err) {
> @@ -5891,6 +5916,10 @@ static int load_module_btfs(struct bpf_object *obj)
>  			break;
>  		}
>  		obj->btf_module_cnt++;
> +
> +		if (obj->btf_module_allowlist &&

IIUC you don't need to check obj->btf_module_allowlist,
because obj->btf_module_allowlist_cnt is -1 by default?

> +		    obj->btf_module_allowlist_cnt == obj->btf_module_cnt)
> +			break;
>  	}
>  
>  	if (err) {
> @@ -8426,8 +8455,10 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
>  					  const struct bpf_object_open_opts *opts)
>  {
>  	const char *kconfig, *btf_tmp_path, *token_path;
> +	const char **mod_allow;
> +	int mod_allow_cnt;
>  	struct bpf_object *obj;
> -	int err;
> +	int err, i, j;
>  	char *log_buf;
>  	size_t log_size;
>  	__u32 log_level;
> @@ -8470,6 +8501,22 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
>  	if (token_path && strlen(token_path) >= PATH_MAX)
>  		return ERR_PTR(-ENAMETOOLONG);
>  
> +	mod_allow = OPTS_GET(opts, btf_module_allowlist, NULL);
> +	mod_allow_cnt = OPTS_GET(opts, btf_module_allowlist_cnt, 0);
> +
> +	if ((!mod_allow && mod_allow_cnt > 0) || mod_allow_cnt < 0)
> +		return ERR_PTR(-EINVAL);
> +
> +	for (i = 0; i < mod_allow_cnt; i++) {
> +		if (!mod_allow[i] || !mod_allow[i][0])
> +			return ERR_PTR(-EINVAL);
> +
> +		for (j = 0; j < i; j++) {
> +			if (strcmp(mod_allow[i], mod_allow[j]) == 0)
> +				return ERR_PTR(-EINVAL);
> +		}

do we care if user supplied same name multiple times?

thanks,
jirka

> +	}
> +
>  	obj = bpf_object__new(path, obj_buf, obj_buf_sz, obj_name);
>  	if (IS_ERR(obj))
>  		return obj;
