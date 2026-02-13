Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD3208D0
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770962174; cv=none; b=IqLqFezHutbCAsPtCCYendKyMv9+1hKHuzwWkJqSvpG3/yZJu9rmWqiSLfiFaq8WywtuSaaJ/ATArqRcxMpj+lipGyZGUXt0JBKqT6oOfzpfLcDXT7PrqaehzbZw04+ltYvXHM5EF4bykkwdEWjhrETR+bUSAVdl8grhX9Hj9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770962174; c=relaxed/simple;
	bh=gMx/xJtdPv8JiXu56XBPpl17KJTDJRvNUmbPtk1NIxU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GvAZmUbmo+aqQooiYx0D+a6XOmkO0chIY4spwIjlpkUVPBxm1zct5I8lS9uJ+BqnxQciysqakDG9funKeXlJQB08YbBbwjFdffNhnrz/R6GTwfJi8yEJP7f7xzt3aWrp3AqyFAL9v2aYxZ1UIr29ath4RlAjsTCBg0qeu2WFg0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vGEEsuVd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGEEsuVd"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43591b55727so561349f8f.3
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 21:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770962171; x=1771566971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0pstr0CqGFV/POAeFNEcdC4qpoZ3OLpxLO2SLpCn+k=;
        b=vGEEsuVdyksbML8B00UF5knqSEOotz34p85s7Mu35GpI2MfpTYQbe6SKS9PTU+h0fC
         73r8GK4lOn7a1yWlLjchiCe8MWNn8n3Cqpp4fkILh7y9Zda+QMrBnAIJbQKPKgd5Y48z
         qiZdbW7WQjjs0l+MhaGoGAiP72jAr4E7fCMDefZiHTQcvylq9lYTYAQ38mgv70bg+e7s
         mj71u/SF9spDwmTPhuUSwzwhDpDlOiwVu8XcdnTJLAuSBvKdwksS+4DIijlspsu3vq4K
         OWWxbP5aMIcWoDtcqEjI61tlJ7OZb5/eqiWU86m4K1oNO7RTEoxf1HWJ3qSQfdrCdL6j
         dZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770962171; x=1771566971;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0pstr0CqGFV/POAeFNEcdC4qpoZ3OLpxLO2SLpCn+k=;
        b=OwLtSZsBL4aTALVo28PQiU6Kwk1mNkSwh07Aq7u6I3T1EnbqedfG56V1dWL/2t9+Wl
         OANdvUDbIgRBwuSAFLO3q3hFeZI6lv9dFI5JwToefn82DeA/6weXIK+SoioRPu34rjyM
         suAVpvq6w9ZFQqkNokANMf6Ca9SJA1ZpzJBHty5vnyq7tHt04szzcRgRxBhDXtDZHCJj
         wGcUggBpd/jJyG2Qo1GepyHMDZ+VyTeMs4Vc6THwji9d2Ez/fkVMni7tu5Qu4mZITa4W
         Jt+GebPJYePJgB5Hlekld2eBUYU1Gn4tEeKB8n3SXLm+PPXLTl7/2pSjinlsXpjrCwXP
         Y0EA==
X-Gm-Message-State: AOJu0YwTpo6gPeZeV3YR4+zUQtdECxIsoNNqDwmN/RrKpjFfcsf8WXfL
	RRFXWubz+HhqKIO1v88pkCQ6mmquUeOvrXrUEmf5c1qa61bC3xjCDh/HrI0c/bDGtXk=
X-Gm-Gg: AZuq6aLwVg/FOLSma2tMWDQm3s2CaCv/T5w2Kv5THwOBh02gXcAAZclnGIBmxkW2dwD
	58qedjEE9h2gevpLxGfGaO0llhtr9nThWJBSHylQyuGg7CUMOwZ+FZ8EnHM0X9AWHeKN7JHPU6E
	JuHMW7LlCfXFIKwasBtzfWFvlOJj3A8pRVRNUMyutzRS7FsC82VUj+iPNwwwTrr58QGEWzYCosP
	aqEgpqUfti6I4cBb1ILhddTrFOwRvnV1AllVqt1p6gmpQnsBl2JlH5SodpwJWWuTQ+J0vmPc88q
	BnUq7xbd0fhho+aAENS0InmyuqdIOzslk9gGAJqQfvtOA5j+30aVN7CDPid2w58atCSRWjdGh+a
	znemKF1MMHLbEiBHISSEM7gsso0EVp2T6DqX8Oiack0dwrBenSMLpu0ksX2kGBWm9bN4cQWGRbt
	mh2aNOfpH3+rdw3P2ON4VZo/byHEci
X-Received: by 2002:a05:600c:820b:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-48373a1bc0fmr7411665e9.11.1770962170967;
        Thu, 12 Feb 2026 21:56:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a298b5sm9208505e9.12.2026.02.12.21.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 21:56:10 -0800 (PST)
Date: Fri, 13 Feb 2026 08:56:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] bpf: Fix a potential use-after-free of BTF object
Message-ID: <aY689z7gHNv8rgVO@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>

[ Smatch checking is paused while we raise funding. #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Anton Protopopov,

Commit c81e4322acf0 ("bpf: Fix a potential use-after-free of BTF
object") from Feb 9, 2026 (linux-next), leads to the following Smatch
static checker warning:

	kernel/bpf/verifier.c:25375 add_fd_from_fd_array()
	warn: double fget(): 'fd'

kernel/bpf/verifier.c
    25360 static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
    25361 {
    25362         struct bpf_map *map;
    25363         struct btf *btf;
    25364         CLASS(fd, f)(fd);

This assigns f = fdget(fd);

    25365         int err;
    25366 
    25367         map = __bpf_map_get(f);
    25368         if (!IS_ERR(map)) {
    25369                 err = __add_used_map(env, map);
    25370                 if (err < 0)
    25371                         return err;
    25372                 return 0;
    25373         }
    25374 
--> 25375         btf = btf_get_by_fd(fd);
                                      ^^
This re-uses the fd.  The reason behind the warning is that the user
could have changed the fd to point to a different file from the
start of the function.

    25376         if (!IS_ERR(btf))
    25377                 return __add_used_btf(env, btf);
    25378 
    25379         verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
    25380         return PTR_ERR(map);
    25381 }

regards,
dan carpenter
