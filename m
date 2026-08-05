Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2D93EB0F2
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965317; cv=none; b=cUBK8kynGPaGfKCfBkTBVOAom0Mmo9RdRum46WnghQaCZbneZYNg9IYBakRd4h89JtNGYJLbLVfEZQavh0e4Ckyk5oP940vlXdpNPoL1sVKXK7Zif73yhSykaH/dIx/2hNRH3OEOPCZE8jks+hO+fcSduGtRuHMUxnYanzRCuzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965317; c=relaxed/simple;
	bh=PGl07G8iMElVblfgcHPrJNDO395EjtSYe0F3lU9MHYU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGRAB41RLZT5iGIVGtBs87vyHeydUAXRA8GyiMmq1hoiQCMkxhXHaL8wQiZDr3o62h7sEh1eT1I01N89ecGGKg6H1PP/DBUIL+xM9qruEEqDppOFCnLFQXsXFsI4Tb4bRENIW0XJf2CLsUmq0hFADswiAVpAC6xM5qcufMtT5JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmXTmJ3T; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmXTmJ3T"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9e7391839cso1420228a12.0
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785965315; x=1786570115; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zk2XFULYPWX2ORFO4Rdsvil62YudbtfCr3X7U78zkzQ=;
        b=TmXTmJ3T+EONHtW9KxjSAbIK4Pro1c1Wxri84khlQ6ZKfXB6HE0slRtLw1GHEZSwTP
         76ig/R+Mgt+omMM/cF5DqNo9+lASF1jdzT4KqeKEM7PMVipw6M1ZXHeNYd0rQaoAA702
         iDYEeUq3rdFgNtfKfO7z8cmRMrWnRHoUaK/SKFyQwhxLjREHvMsTsZqGlShqtYOE+sKX
         ZlCu5rtor6uVUZmTnS1eoCKx/2WFSyq7+YoCikL4of3jzF1IY+w0usAwKbEequUSuMRV
         pb0dsL+g6Iyq7U0epur3AxrweQWRJKbg8DXuoDuV48lclk8eQdnqe67keajKDxMMjtGi
         xlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965315; x=1786570115;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zk2XFULYPWX2ORFO4Rdsvil62YudbtfCr3X7U78zkzQ=;
        b=lnBAc5yjinwZZMb1edlu9IwZncLL5PSLg90nk2Dm2uI3Txf66xjJYPTU9P9REVXwEN
         0FbGr0yy3en37FUKW8fM/V2H6BOf946M+ZUF+1icThR9shDCRCPu8f8JtpzU+xwSYA5y
         Uyc0SmvqbQgETBEBU71DlaoxWsnRxREB+kHf40RGbFBPkdeXrjDnykTabshjQb6ZiYht
         dyUobguOccqsOIlrrEFClJYD2d1wKYlUKxoZ56bJXABZnAkLd90DYpWdcYQvRWtz9dA/
         HBgRq5oXly5RzBOD/upj5Zn+gZuci895JW+cwzadYaBmDcFqwvmd10ojoOCK+Tsf/zQK
         ytfQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgJiloifM9gCcLeXCtZSgQkseOPGms6lhLy2IALRVZ4yHwGH5nNP36ncImFc/U1Bopax4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5WoVqZmOILw1ao1ccT/g6FBBOfLYOL9++JX9N6CUICG9RuxfL
	GTU4C3OY0vwutcLFw6WuKV6vZpMZZXwsUv76PUIF8hLN5XQMJT3TnfL5
X-Gm-Gg: AR+sD11cmNphIBwmC+hpqDxgcpbbitDrSkzzjs1DJUfI6IspNC0sti+TvEPJ1Up2ISv
	NxEUSy/u07gRd+5YeUHG3kYOrtADfdfnbkBw5dZjvEiCI+KA3lopyojvA1ZGxaguEkGwOsXVChq
	kgyO0OsYVNCkxSWc+pImK2BQPIY/qdDDJSY+8W5u67yyKe0TB6VgWDrCmLnpvzMtABUf7ODAjtF
	9/Yrs1t9vjW93yOTOHe4aAp0NcI1Zvi0DqWFwFrqNMSsws6kaFkU8hw7564Ow/TRJtmA4+6AJSB
	aVO3fLPI5WnmJDp5VexcOaiSgaCP8Vnz4+G3RPH0fM3eT7+dfEi9U0FpjRkGCU4RXbGv+2MQpTH
	0HIsuY1BgLcQu32/c4alXtSkDvbxJ23SjbjwiyD4U9BApgjVOy/189v8Aq6FEz5lbegA4a8AYXa
	5yx5eDDtkU8VkiQKuCTef5mhu68Q/X1HfDrQBFv1oJMqT4YeP8GhrOliamnfrjwSAMtYIRT4lo8
	xM0P+cFmXg0LXBVwDM7KIaj0GWhOrjj5rkuHpaamrDu
X-Received: by 2002:a05:6a20:3946:b0:3c0:278c:6a31 with SMTP id adf61e73a8af0-3cb85dcb31cmr11076825637.11.1785965315388;
        Wed, 05 Aug 2026 14:28:35 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:969b:c0a:ff6f:454e? ([2620:10d:c090:500::5:b61b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca908068sm17091564c88.12.2026.08.05.14.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:28:34 -0700 (PDT)
Message-ID: <16bd5e96eaa2376e1e235b280141ade8486af206.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 2/8] selftests/bpf: drop stale and no-op
 lines
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Wed, 05 Aug 2026 14:28:33 -0700
In-Reply-To: <20260804170156.1709916-3-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
	 <20260804170156.1709916-3-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 10:01 -0700, Mykola Lysenko wrote:

...

> @@ -480,11 +479,14 @@ BPF_CFLAGS =3D -g -Wall -Werror -D__TARGET_ARCH_$(S=
RCARCH) $(MENDIAN)	\
> =20
>  CLANG_CFLAGS =3D $(CLANG_SYS_INCLUDES)
> =20
> -$(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS +=3D -fno-inline
> -$(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS +=3D -fno-inline
> +$(OUTPUT)/flow_dissector_load: flow_dissector_load.h
> =20
> -$(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
> -$(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
> +# progs/cgroup_getset_retval_hooks.c includes this top-directory header,
> +# which the progs/*.h prerequisite of the BPF object rules does not
> +# cover.
> +$(addprefix $(OUTPUT)/,cgroup_getset_retval_hooks.bpf.o \
> +	$(addsuffix /cgroup_getset_retval_hooks.bpf.o,$(TEST_INST_SUBDIRS))): \
> +	cgroup_getset_retval_hooks.h

Would it be easier to just move cgroup_getset_retval_hooks.h under progs/?
