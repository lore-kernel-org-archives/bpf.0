Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB13FB89
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853449; cv=none; b=OXHP4p/eSUuCVjo6MbibZXnHANF3KylqZpF0ym4owxOGiKhMiEEOwOzJUejzPYNLcsx6cbL9jYPbXl3a1TD/cvVe0JVfPUpt5aqevOBf5qNrhU1/RFuqMWvqktG/SNLEDyC+/36AV/C5Lbkp8p6e+LPUnh2eTsKOJKh7ja/ncIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853449; c=relaxed/simple;
	bh=j6HnVN1JuRZFf8//cHAX+HXjYQxXNt7MOFOXesdma98=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/Wu8RH0/atuX0ZloVT6lkcpmW65reEKZnEfbhTrTWs4SMnbJjg0S5+1Cc8Syr7jdqnTrZokc/y+V1P+uU0UDDP+o5NdydJ2zxwPdoZWaR0fT7iyyIB3ScqF08rSdXN+N3OGAPcvDDpo5SO3mPhCY/gkwVeGVlniJhz7Q6Nq4n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIn0wB20; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIn0wB20"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so1367797a12.3
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710853446; x=1711458246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E8BKSKr8NQpSbuxOLsWPNT4FYlYRbQrTGRlzGrs/PbE=;
        b=kIn0wB20VE38z5XbbObNU+QF2mNKcFKG2ZYB1Z8ga9/ROk8BTGDyjIRuhHhgIUt2Gk
         u1jWyB1RqpAyfmldCdaDxHXRQ6XNEiglJ40+f7bzaEWx8g2Oj5Lg9YgrrhZt5w8ekN6y
         ndDGi/XfzbzaJ3OCRf7+VWV5Rc+kAc3c8GR7+1XeDnQnUzRXwayqkZra/JWJwMwEZsxr
         lgt/dswgi/Q3HXpRmm6rchOSKXVmSuUD7eemtZvyM91f++J+TLOdkiO9r9/409NPsAgc
         zOTE4Frvk0GmTLUjMH2phzcsVcFP0mojEG39dZ6oI0/33PiMubPjno8XXmA2D0Dng30b
         9AKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710853446; x=1711458246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8BKSKr8NQpSbuxOLsWPNT4FYlYRbQrTGRlzGrs/PbE=;
        b=q0SZmljh7C6KldWnDBdhU+WlBI7HpvLyla625tj5dGoZa6UdKWsYipQkIzTGxxx2Bj
         ghl6huITOkANsoyTme59zbc1fV3nlJGAr4otS/V2O1G262Q0TDzexehS35jvGFf+Lrv2
         jh4UjaXioYjHPmJ9raYr/aNOz5qA+cAcJlrDPJrK+u9+rH34WtayHdWVvXyaxe4o1ZBv
         76YJurSiWWHWSN9YLRfnOU0nq2+E7UuVuyZhkonN5CUBpWM0xFBTnGv4nVbmeOzfrS35
         6t3nc0o0l1QSOHQuAdhoqajC3I05nKt8wwO6/CtR7vnG+fYpSp7KxBn2lgAQyFq8BWps
         gkHw==
X-Forwarded-Encrypted: i=1; AJvYcCV5UdggR48Eew5htVViibW3TgiM1Fj/vvJ/Y2R8vElLzHV+kDAaWAwF2YAelItNiEzRyuf/M3B/VB6sOb46jvCz1pRH
X-Gm-Message-State: AOJu0Yw9YPnqpY4NLUrL/te7IkdXBUZeZfp33PHZSCdlD30fFvNlDc16
	7+uU4uZGK6wAVoIuL4UMUQ+32X+1AUSGy5GE6nleU7j/WLOyJ4xV
X-Google-Smtp-Source: AGHT+IHl1//xIju5Q44yBl/WxILLbq8VinKfxds3N2Afio1+qAvovEMT6ItbsgTUDWPv/qWGn3i9aQ==
X-Received: by 2002:a05:6402:5507:b0:566:47ee:b8b4 with SMTP id fi7-20020a056402550700b0056647eeb8b4mr10681949edb.17.1710853446168;
        Tue, 19 Mar 2024 06:04:06 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id fj12-20020a0564022b8c00b005685eaa19d2sm5738246edb.5.2024.03.19.06.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 06:04:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Mar 2024 14:04:02 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: acme@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v5 2/2] pahole: Inject kfunc decl tags into BTF
Message-ID: <ZfmNQomPNYynumS_@krava>
References: <cover.1710532093.git.dxu@dxuuu.xyz>
 <088c4362fa9f080c319df7c49bc6a4e1b6ae98e7.1710532093.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <088c4362fa9f080c319df7c49bc6a4e1b6ae98e7.1710532093.git.dxu@dxuuu.xyz>

On Fri, Mar 15, 2024 at 01:48:52PM -0600, Daniel Xu wrote:

SNIP

> +static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> +{
> +	const char *filename = encoder->filename;
> +	struct gobuffer btf_kfunc_ranges = {};
> +	struct gobuffer btf_funcs = {};
> +	Elf_Data *symbols = NULL;
> +	Elf_Data *idlist = NULL;
> +	Elf_Scn *symscn = NULL;
> +	int symbols_shndx = -1;
> +	size_t idlist_addr = 0;
> +	int fd = -1, err = -1;
> +	int idlist_shndx = -1;
> +	size_t strtabidx = 0;
> +	Elf_Scn *scn = NULL;
> +	Elf *elf = NULL;
> +	GElf_Shdr shdr;
> +	size_t strndx;
> +	char *secname;
> +	int nr_syms;
> +	int i = 0;
> +
> +	fd = open(filename, O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "Cannot open %s\n", filename);
> +		goto out;
> +	}
> +
> +	if (elf_version(EV_CURRENT) == EV_NONE) {
> +		elf_error("Cannot set libelf version");
> +		goto out;
> +	}
> +
> +	elf = elf_begin(fd, ELF_C_READ, NULL);
> +	if (elf == NULL) {
> +		elf_error("Cannot update ELF file");
> +		goto out;
> +	}
> +
> +	/* Locate symbol table and .BTF_ids sections */
> +	if (elf_getshdrstrndx(elf, &strndx) < 0)
> +		goto out;

nit, missing new line

> +	while ((scn = elf_nextscn(elf, scn)) != NULL) {
> +		Elf_Data *data;


Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> +
> +		i++;
> +		if (!gelf_getshdr(scn, &shdr)) {
> +			elf_error("Failed to get ELF section(%d) hdr", i);
> +			goto out;
> +		}
> +
> +		secname = elf_strptr(elf, strndx, shdr.sh_name);
> +		if (!secname) {
> +			elf_error("Failed to get ELF section(%d) hdr name", i);
> +			goto out;
> +		}
> +
> +		data = elf_getdata(scn, 0);
> +		if (!data) {
> +			elf_error("Failed to get ELF section(%d) data", i);
> +			goto out;
> +		}
> +
> +		if (shdr.sh_type == SHT_SYMTAB) {
> +			symbols_shndx = i;
> +			symscn = scn;
> +			symbols = data;
> +			strtabidx = shdr.sh_link;
> +		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
> +			idlist_shndx = i;
> +			idlist_addr = shdr.sh_addr;
> +			idlist = data;
> +		}
> +	}

SNIP
