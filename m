Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D33D1C860C
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 00:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408382; cv=pass; b=QrovwFJOzzGygVdGUXDj7x5o7xKTQVAIP/kxYl7hhl2BSK9YYnp4ziJSgYydFbAwq1SQU7RGZX0gJ+bWLhP3RLqMe39etPtBCS+p0XF7D4b1H0dmJqa+QgrDjf8XpO96uI3TElmCj8HCT69fh5J3kJvR03N6v/1eWYkcJ0KHCWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408382; c=relaxed/simple;
	bh=XP3TqgakwJylnRUqvCpSJ/dguPAgZa3K7TnNtlOKoWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjlJk2hn2iOlKXQw4re+8fFw51Tfq8nvKI/bE6VktA6yE9msSd7I+WwpRhLrh83eU7fEQS1/vMhhdbfMZ97WF3jRC9Dy7XCE+Y0t7+ENwqeyXpYRW3f2FnNLEO7WfGlQJcbAE6kwMu2zqzznpKP+ITpv0xNdnij7W7Qu2ldHxGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=syD5YRd7; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syD5YRd7"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c9452244aso20257371fa.3
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 17:33:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786408379; cv=none;
        d=google.com; s=arc-20260327;
        b=oTAxGE0M0FhbybmVZO/zI7+5uC9f7kAJ7+hf5Zx+9WUftyFTF3OmfaKKhhTZ5DSLMT
         hap+pUxZ1U42cwc7v4RIGZXVnDKctvrQiOcDpxxlof+YYPii0zDtTAsCwrlHfIjnHl2b
         kV6nf2Er3wH32K64b1l0UOSDEZTH45cP5ZPaYZD0GWPGSgDPqlu7n46HnPmTYWoGxroR
         AMppR4e3PLkC4AoH84DCPm7JQPh3dyenf5W2adJ8UzdR+M4zg+9tKPtrP+ocx5Si9AvA
         DUP/+XfGHVrVyf7/UMCO/g9ofFcLmxHrNuSRnJJv6GYfOL4o35os42l01z3kxDaLUufX
         fO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XP3TqgakwJylnRUqvCpSJ/dguPAgZa3K7TnNtlOKoWw=;
        fh=MId4ELYt2oj0RoAwFuRRlldy5Dyb8PfC65lF1bNFir8=;
        b=FZ58b9wUlAURaf+zfurDojk/mmNyUl738/WBCYnEvVC9OKO8T9Esu1R6mYkKLhmKpB
         TAJl6PsdYJnunHMGMKyA3V4EkYwM93j0sbTXOS6OoBtlIfvuxPHWPdTDLGVweE/+vAfQ
         z4TGLTe0LdMk4zLxhBDbbEsEAqaiDf7D+bsXJ9nUE6gnM6VmXEdN8V8fstM/a8Ou85am
         tTHQXEscxL+7yy8aDUBUY5TNzJ6XsCpMwy9kZKxDwyl/9JmVqSVS9LL29NZ2eOvuKfKw
         78ew7iiELW73UvzauCOlYAkeFSAg0TUw7Qe8nMo2nbG6xvXF+t4FNcwKuXlP1e2tXjNF
         Hctg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786408379; x=1787013179; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XP3TqgakwJylnRUqvCpSJ/dguPAgZa3K7TnNtlOKoWw=;
        b=syD5YRd7IXGXFRTvadkWWLcUQvx/mhgtbJoxEdvzYtkBGAacRD1Q3+KGIre5kQehKm
         5tGHJQ6BhgA6soi4gce9+BjdiJyOdEyrvdFzGAx7dOfcxFyid9tupPaKqWTvXrDnE9wQ
         xWriKWZj+KCIziDJP+9dzCk+zEb6I9JrtNnD6Xmu5LddTLrRo6fqDYzfCHC5cXj9jczF
         axpM1MaQrn8+xXEfkjH6cf1oJFK8Nh1li30Y/j6ZXGAtfNFtdHomRz6psvI4Yeu9TQLk
         Ph/EVl3pK8VyYpWwc28WmeOWOCbwQ5zayNX/6uhh2VFJXN8RNZhsu174Jcgj1cKYelV2
         wKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786408379; x=1787013179;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XP3TqgakwJylnRUqvCpSJ/dguPAgZa3K7TnNtlOKoWw=;
        b=o1qrjGePpemCX/sG5FxALa0Wr8MX6SwnNNyF6aMYeHkUJTv4XVph7BHljdadLhBVjN
         gnFl5Uis5Lm30PxGBGmvqt+b7+gUCHSxjdP5s/sguuGBQyFI5Xjgc8qXW61eF8k+cHip
         ZlmKTs/JhzRfvl4qTtsSNfI2Lq2yJkE4n6yllpHzxTSW3Eca3PY0KVvq9pWTKpoayPN3
         swfNo6KFmlpPhOwI+0MFVLf2HGqpCPdo5w3Uonnh9wa+ukWwZEIOqVO5iQvHRus/XFPM
         1x3tqO+RiwbNK1UDdHiNMHqw8L85peQd5b7oa7hXGxTF50XpmpH7GeVcg3w2Gr14VrWn
         4Ofg==
X-Gm-Message-State: AOJu0Ywg2HRlNguGlK1ALCsR82CvmWPUJjxdU4gX0K5fv+LdFHTnAmi9
	SV7W0fJUsUFvOg8yjP/FGx141IHFfqc3r2Z3YINzQz2XpO0fvZYQBGkcsNfLqekxzptyr5rQLQo
	arFTLYwWECwOFaaUIpjqjLf5Fo2l247U=
X-Gm-Gg: AR+sD11vGErZrHn8Cp73mWpiWE9EAXpP9d6+VD22GtJ4KhooxLL/u9gC1D5TOxtyO8s
	1pPPkpg/IWt52HlojHcECN7TkzTo03yh4UXeYoWfLu1lh3tFIbCjHr7IHHZE0M09qxq97/fNHH2
	eJklHOdnovWS08BOoX0T6sjLsn/Z+8V1vHWqbIVFg6IQlzc9vhuTBU+le6YUqifNjkbR/NBMuiY
	Bs1sm00vXdX75jc2oHZ2boZh7ffsOSg3TIsv6yYNH8uMW/RT/NEnax5x4Zmo21XmK9rXbAe0RlN
	zla+BPn+Gl84R1tKK5Qwz6r9odupOnxSdWgxJJDonBU=
X-Received: by 2002:a2e:be0b:0:b0:399:8a8e:64e4 with SMTP id
 38308e7fff4ca-3a00eb4b61cmr5958551fa.19.1786408379076; Mon, 10 Aug 2026
 17:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807004320.134069-1-dingning04@gmail.com> <20260807004320.134069-3-dingning04@gmail.com>
 <394bdd5e8cd366cacaa6ced8a32e851b43e67e11.camel@gmail.com>
In-Reply-To: <394bdd5e8cd366cacaa6ced8a32e851b43e67e11.camel@gmail.com>
From: Ning Ding <dingning04@gmail.com>
Date: Mon, 10 Aug 2026 17:32:48 -0700
X-Gm-Features: AUfX_mwMwKbovu7w1Lz49lFbZbsDmDoYfjTjvzEPUac9FeFFpQtVZqp2OFhR-4Y
Message-ID: <CAJP4iutckFTf3n3yKwRCt0u3ojWHKbSNX0vJ7TBim5A=En8=kA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test RCU iterator state pruning
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, memxor@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

> Could you please convert this test to inline assembly?
> The presence of 'likely' might not be sufficient to guarantee
> the codegen pattern, so we usually resort to the assembly for
> tests where that is important.
Sure, I will fix and resubmit.
