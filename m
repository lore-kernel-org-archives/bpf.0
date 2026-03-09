Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070E3ED5BA
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079051; cv=none; b=BBv+kzY5WgOjhwc15tchlUMYeXECEsM5a61xek/qS+acRSuFkzFxYiY2Tftc1tv0f5THyN/u7EHDtqfAIzcNc+VEunrxxvMD60YtPbAmwrWk/b0VYXV+KVZK6cI7ZoqxRcQOHUPGwcsruqXOI7suEfdcgaWp43XP1CnzRRcJgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079051; c=relaxed/simple;
	bh=+S//EYTeg+eBMFnRclI4DZ10Br0zANx6GasdaTOUlik=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eMmSd2Mtq0XC8kKP8yvUeWtk0jOuRjmTBc+edA9NOTM3joJzlJB86H/NqOU/MWWrmodjEjhB6/6qfc6k05ZSMIU3oSZI8lIlCeqznm+r4uTLvqXi7swDloeDJspq0r/8ICno7YnQuXMypUX/WlM/2crN60uuEx0MS7+gwZCXi+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=ZkBQyLHb; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="ZkBQyLHb"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1273349c56bso14302087c88.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1773079047; x=1773683847; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X05FCRGVJWpxMA1SAoz6rgM9EZ5Olr2Nfwxy+CAzJCk=;
        b=ZkBQyLHbiisGXiVYT1qVJCI3Ru8hohXQl1tsqd34WMnyIROorhD95ifsztyv91Y2YT
         UEVEzolXBuJM7Jpr/AXATtLZzB4/+2V2bsYT5PiLSJ7xuTfmHzZc9Iyp85ld5SN71vSz
         SHXtIUln2Z4ikmCfafyHCXOHQmIpbdx2H09WkBtANsw18W/gbYT5NDppvjuK5z6XLIf8
         IAkexgWI5RKbAv/tx4mT+cOGTJQLztVUC7pdlT64i8BrIvuK9daEviscrDUHYShY+G6x
         pmVniS6tayzazko+BShk4Se0ClMzJF4Bg54IJh1Ogu208Flzi1DmYL3OA3+ia9nH2Gv9
         oXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079047; x=1773683847;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X05FCRGVJWpxMA1SAoz6rgM9EZ5Olr2Nfwxy+CAzJCk=;
        b=YLa0x3AHajYqR78GcQzUpJF7tJyUGjK29xxE+J+2byNh4jAwsAS/dT+MiisOnuMa9P
         PFPTFkiGteMUfXkKuuQ6bAE60yc7p7LHoASN/sfokw0g7mfiv+pMVCzcR4sAJ0YrNoG/
         svjFWBBTFcxckRSnKc0ojK4JzfvkpMQ2vKpuWz+T59LJfBVa80cBW/dJyT09ulDjXuXf
         buJkyTKULpLNdSEtFVOknrv2Jl4aN5yR8oZZIxvHKycKlKTK3EofZtvI7a+vQowMIdqZ
         6na4iHKnPMyddhhHPdlMcZ6gjJXqZMD3SdtctTslWZTsq4n6Q3vKr4xofNwGGxxJG3ag
         tmxw==
X-Gm-Message-State: AOJu0Yz+uY9/3aiyTdzH1VUazF+Ue1KaNU+Z4gpoaRxYYJh+Q1cS13Yn
	qBR9S5tpEzLBYarhH4QUff5LjDmUTVJYQq4joqfiWLfLCTGE1SYXx7zvF6fRGppKuNA=
X-Gm-Gg: ATEYQzzGHrIhmkup6fzjJIGXIdC35HeJS3ZSUeWHP2/0P7s5fkxTDZ8zuZ4pNBMF+Sq
	43vBbRhjQy4ZKQjmz5JRmXFTSCNuo8z7/B5SPcOrfQzR92+RVsnnMAI66yiMYbRsxBMj+RluCWi
	mW377oCSThH13ixP4PsAfTGqcMg1S771lBCWQRoBLH+ahopJ5+wmAxnk0a098Qa2l3jqp6dYHKC
	C8G6a6HsVtBZwqT8XxxTzNSHVzC7n6bqSfj4RSJ2dImw814zO5ZwTsldhscwD2atQ9DURCDqUAo
	clx4uy4k2OIFCqIhAqJGpWdEqcd+/Y5jZxZan9J1NAdPViqHWvp9N5l6tO6f9ad8SHxitJ6jqXt
	bP188Gt7oJmBddf2LabR1/aK3xT0yik59tSViy19ZntdQ4eZ9eZG9saFsmEndJn28uBfmgFVK44
	jnJ6UOvLyK2NQ8+L0Nl4yVDL0=
X-Received: by 2002:a05:7022:2385:b0:128:ceac:6db1 with SMTP id a92af1059eb24-128ceac6f7dmr3310979c88.28.1773079046921;
        Mon, 09 Mar 2026 10:57:26 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:5a82:9cc4:34:ba95])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128d83495d2sm4219088c88.16.2026.03.09.10.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:57:26 -0700 (PDT)
Date: Mon, 9 Mar 2026 10:57:24 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org
Subject: Need update to libbpf/bpftool for bpf_stream_vprintk() removal
 (kernel sha 0cecd492f516)
Message-ID: <aa8KBN1kQnng3yma@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Andrii,

Your libbpf github sync at [1] happened just before [2] was merged...
would you mind syncing that bpf_helpers.h change into libbpf/bpftool?

    In file included from skeleton/profiler.bpf.c:4:
    libbpf/include/bpf/bpf_helpers.h:318:12: error: conflicting types for 'bpf_stream_vprintk'
         318 | extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
             |            ^
    ./vmlinux.h:128001:12: note: previous declaration is here
      128001 | extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args, u32 len__sz) __weak __ksym;

I'm happy to send patches if I can help, but I'm guessing this is one of
those things that is easier to just do yourself with commit access...

Cheers,
Calvin

[2] https://github.com/libbpf/libbpf/commit/6ddc03d4fe0535ac0fb6c8525db31ac88a018ddd
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0cecd492f516
