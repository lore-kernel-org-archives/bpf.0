Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCF6C43334
	for <bpf@archiver.kernel.org>; Tue, 12 Jul 2022 08:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiGLIby (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 12 Jul 2022 04:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiGLIbv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 04:31:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F0BA44C9;
        Tue, 12 Jul 2022 01:31:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u12so13010210eja.8;
        Tue, 12 Jul 2022 01:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Rw0D6MOQNgwtHVy5EHhS3LDpVuivadaMB6MVJn/OAoU=;
        b=QzuplMgfE/kFHk61XSAFjXkGGpuBQb8Y4wEsuENnY4rAjcrt0BRibp8s0SR3/Q2ubn
         GgGQgJw5rN0SzQOG41e2Dpfo1zJNPW7JhLwTbWRER4JrUR5e0aPuxPWXjSc9Vile+IuV
         ozVYcMd5XDdrueeXqCWgYwRaRCXJPADE/PGCVHRhI9jlAkHVMJ3ihOT8v7SbH3YMbI4r
         NGdlCKDXzZVA5DPbqotjPS0Cd5INpaKe7/hJPms0iF22a4KW5egfcAhcUzPWNady0kEk
         LljI14XabSEc8dUlW/D3tnqeHRr4waCa60/k3BbQ714FGUGGnudFBhPltOuW8w9lyg25
         qWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Rw0D6MOQNgwtHVy5EHhS3LDpVuivadaMB6MVJn/OAoU=;
        b=KA2yYBd1tHPB7P2IIn6RKJKgwKd3K1Q55Vv4++j3u2Z8/cdiXRG0je9F7GhGqF8xt7
         AIwWEuI/O5heT5SRKXccgJ9uvaIOgfLkWa3hS3CMprutjodBLDB+8o3wtu42n4f5/Hec
         h7uK6+yYY3jmoQslbcw3SBBsSZtQOQY6TJeiUTwM9emTCOq65N0iAlbOqbH9ZGXZVwi3
         Ba+T0ay/gWqY55slgOSeVVhUwJPSQfBdtarEgs3GfDJbHxW6WdJvVP5XPkU5LRqssKL3
         bI5gI1zk452BfKiA7sCtlabh45bdsU08rNlH+K9O+goqiXdD3SOeIL7+rOqM+Pw358MB
         VoPQ==
X-Gm-Message-State: AJIora9gtHjbcbBCtS/LaCb7ap+KtnGVrpW/Jy8YKOiDbr1aFRB2WuL9
        4uKb4dH48/VT1+RdRgq/ZT8=
X-Google-Smtp-Source: AGRyM1sCGo7oWXUoiAf19HelQ6cTyYc12/s2113N0rki2LPZ8TVyFOBl4AyWQ5vH/V8FxG1u3/XVUA==
X-Received: by 2002:a17:907:2cca:b0:72b:4188:f95b with SMTP id hg10-20020a1709072cca00b0072b4188f95bmr14594494ejc.153.1657614708272;
        Tue, 12 Jul 2022 01:31:48 -0700 (PDT)
Received: from krava ([151.14.22.253])
        by smtp.gmail.com with ESMTPSA id fd9-20020a1709072a0900b006fed062c68esm3531509ejc.182.2022.07.12.01.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 01:31:47 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 12 Jul 2022 10:31:45 +0200
To:     Anquan Wu <leiqi96@hotmail.com>
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] libbpf: fix the name of a reused map
Message-ID: <Ys0xcf2yRG4fjkBY@krava>
References: <OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 11:15:40AM +0800, Anquan Wu wrote:
> BPF map name is limited to BPF_OBJ_NAME_LEN.
> A map name is defined as being longer than BPF_OBJ_NAME_LEN,
> it will be truncated to BPF_OBJ_NAME_LEN when a userspace program
> calls libbpf to create the map. A pinned map also generates a path
> in the /sys. If the previous program wanted to reuse the map，
> it can not get bpf_map by name, because the name of the map is only
> partially the same as the name which get from pinned path.
> 
> The syscall information below show that map name "process_pinned_map"
> is truncated to "process_pinned_".
> 
>     bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/process_pinned_map",
>     bpf_fd=0, file_flags=0}, 144) = -1 ENOENT (No such file or directory)
> 
>     bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4,
>     value_size=4,max_entries=1024, map_flags=0, inner_map_fd=0,
>     map_name="process_pinned_",map_ifindex=0, btf_fd=3, btf_key_type_id=6,
>     btf_value_type_id=10,btf_vmlinux_value_type_id=0}, 72) = 4
> 
> This patch check that if the name of pinned map are the same as the
> actual name for the first (BPF_OBJ_NAME_LEN - 1),
> bpf map still uses the name which is included in bpf object.
> 
> Signed-off-by: Anquan Wu <leiqi96@hotmail.com>
> ---
> 
> v2: compare against zero explicitly
> 
> v1: https://lore.kernel.org/linux-kernel/OSZP286MB1725A2361FA2EE8432C4D5F4B8879@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM/
> ---
>  tools/lib/bpf/libbpf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e89cc9c885b3..7b4d3604dfb4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4328,6 +4328,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
>  {
>  	struct bpf_map_info info = {};
>  	__u32 len = sizeof(info);
> +	__u32 name_len;
>  	int new_fd, err;
>  	char *new_name;
>  
> @@ -4337,7 +4338,12 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
>  	if (err)
>  		return libbpf_err(err);
>  
> -	new_name = strdup(info.name);
> +	name_len = strlen(info.name);
> +	if (name_len == BPF_OBJ_NAME_LEN - 1 && strncmp(map->name, info.name, name_len) == 0)

so what if the map->name is different after 'name_len' ?

jirka

> +		new_name = strdup(map->name);
> +	else
> +		new_name = strdup(info.name);
> +
>  	if (!new_name)
>  		return libbpf_err(-errno);
>  
> -- 
> 2.32.0
> 
