Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1CE3A6EEF
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578147; cv=none; b=b0U94Jlh1V64GPrjoGiRjKI4RY1iyLwkMsA2IQDBhDdGm+QlrQfSBV+nwqb4WoSnQJttcpQ2Z6tov99U1DaxwEaiUaWTSXqP9gyA8Oei7/UGh5AYWimYzGlbkDE4Nvm8LdXYqP1yjbP8tMQYrS6yyuG4JqCo3842I+xEaHG+RqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578147; c=relaxed/simple;
	bh=XNF7s9LHREcd5HQA7aPEH5IiSz2Z5X4Y8+T33U09Ddw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZXIqnWRErxa/QEC8q12pLT7dq0gmUHmP8rkwO6S6lOAw5zOzvXOJbNdz3MokWpYB+nvZFSR2x1RLcprEHIi8N8ulD7EsHeAnAZKDPal16KsJlpUSNWoAwvYSNk+lWtpPMroSeHLzv0J0d3GahuqNFG0onuiSDZq3PBYz/whERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Jtq/nUwZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Jtq/nUwZ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd24f466598so136731166b.3
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1778578141; x=1779182941; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XNF7s9LHREcd5HQA7aPEH5IiSz2Z5X4Y8+T33U09Ddw=;
        b=Jtq/nUwZa1dPGa6NdaFja2YDd5HRL0trc5c0sOxgfrJHYjUjPiogmL5pT/7zEEz5MY
         CYscMEdq0xpwqz8QE4rAoxrMID/6hRp42gobodZBzGezA5YdOc6iuqLNkGxRHCihNO61
         TnCavyjdppXkV27lKbq8dBc5nMT+XPFbbpqPdd48dBkYn68G0MECcSzhamvplEVMWwlX
         2HZHElMWIJZ2HzW3eBlxORauw4uZ+Hfk8HDFAdldUFySs/4RPWpBFhB0yu4cSS8LG0wH
         GncMV3HnzeDFw+Y4vtymPJrIzIiGoBStcbZtbHibgyCLEN0caKb1h1xnDdU2AcnwX+SU
         wsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578141; x=1779182941;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNF7s9LHREcd5HQA7aPEH5IiSz2Z5X4Y8+T33U09Ddw=;
        b=kqsBg5fdpVTrre8YisYGrlUcEgQC4/Rrp2P6C4vJc8z8r8rgUkKedbIe7jXxie3BJ9
         XUGDJivBPeDcOB+IYZh9qsgQ3fS0CcLNE+AzjT0c7DBvrlIvood1t9xWysy/8/JLFwM1
         Qd1MWD93YwD9dpxETlC6IAD05wwr6jb6zv+fSka+NOFjp73blSajOrMEQPFyrPZrMlAx
         mEJwQf0F3aCcs2K3LLwk4A4Qlcodg3nV387JoRFIPzzMsvMq/SXrPZzMxAbbehlzEtqj
         qZhAiSHaTJ46FolsfS/Qvtqvq6UufETu7JcX5+BrqAR520JzBduCBAUV59lwR5DDf7oq
         NQOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+J3gD77wne5eCd0zeYAR7JVdgkYUmlMQ1LAxkEIsULdJCg6RrB0J2Ln+4WYz5rX+V2MEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmrgXz5Wb481IFblLBBBJHlGMc+UtJSnA5qk6ZdTF1zM3grcmh
	mGabt15dY5mb1Pw0mVxJ44tPxN+afJyZudVspxom1aK2uiTPMOLDLuviVUOZsApVfqo=
X-Gm-Gg: Acq92OHEJsJZkY+xtCqNeQ+HhSt3lMDlHa9mtJrv0/vSYMv0BQdkjH1Qkgu4mBoCPPp
	dbgsj6rFL5AmSQkkln8s808aODLh8gUnqwoMzImKyHW3ooOewEUO1weabVyNedFI6DF3x2TpRCP
	ZmeI6rbXiU/y6T5H9P88FzcepNI/pP023dqOS5cMnFmXcqcFmfwHvdfnCawInIJPXfOKz4qEC++
	HMjjaKrcJFa3I3YO0JCm7Dy7MNLs9Nj45P+sFgXkZASTGc/QQyUb//n/qUp9L3Z55L38bypZ018
	Sxt8y+TjbQWXspo8hQRFk2sTnAfcRuT3JH7xtdLZCXAI6+FsHWllWPiGOqScz9RaNX8Li/jmqi8
	/frzw9+PUE4knPV/I4wYxBlAEzsquTACWfMfrA9q2oW6q6EYpHI4vk2roAE7yWDtNMfkOcURd1d
	UEPe7VT3uHqhOndOlmBf/WeYhaWg==
X-Received: by 2002:a17:907:8b87:b0:bcd:2dbd:8241 with SMTP id a640c23a62f3a-bcd2dbd8f82mr684678166b.5.1778578140766;
        Tue, 12 May 2026 02:29:00 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcfac35c47asm311438366b.1.2026.05.12.02.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 02:29:00 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  sd@queasysnail.net,  john.fastabend@gmail.com,  bpf@vger.kernel.org,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH net v2 0/4] net: tls: net: tls: fix a few random bugs
In-Reply-To: <20260511174920.433155-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 11 May 2026 10:49:16 -0700")
References: <20260511174920.433155-1-kuba@kernel.org>
Date: Tue, 12 May 2026 11:28:59 +0200
Message-ID: <87se7x7z8k.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

General question - do we know about any kTLS with sockmap-redirects
users out there? I've been asking around at conferences for a couple
years now and haven't heard about any consumers of this feature.

If there are no known users, maybe we can have kTLS+sockmap glue code
behind a build-time config option and put it on a path to deprecation?

WDYT?
