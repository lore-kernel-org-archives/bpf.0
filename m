Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0135F163
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783727031; cv=none; b=qwgqLov5YYFA1PzUce+9dHKyjEGPskMPj1shnL5Ff/FUPgkxrrPd1vFk6/97LFdIAdC0Fmwo6O8Gfgn+eAUHPAjLa5o0jce+wijtrPkMRDbkKaITqDS7kW6U6v2J9VM5Tyv4T4F2glZ8kddqoOEUv1Umb8GNfzHmKv1uuCL8TNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783727031; c=relaxed/simple;
	bh=PK5r5CSk1B7XeUp5Kcu4wbVddW3ItH3De22ETA07fPU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Esbal1BCGTmdOdnycYk9faXC7DGNAdwlWL/qvZuTaG5KcRt0zlzXe/kJOuNBOJHYnkc7OmdDIOrVT6Elv6ofw6DuSdU+nSxUdXwotj9USqWuVAGRG+zRIGczKX5nBuMdaneg+zT51x/O4jxMZtpmvC9y6yIUf4v3MV3z2MuNwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=eXxlp/9z; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="eXxlp/9z"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so1050793a12.2
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 16:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783727029; x=1784331829; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PK5r5CSk1B7XeUp5Kcu4wbVddW3ItH3De22ETA07fPU=;
        b=eXxlp/9zbJH1NNXJoKalDj9nnLDgfTOKUABHWnM/0+62h7sUYpdCw1eOrk2yS1b73T
         guJxaYzkVcM3LJghLUtF5Cw98J2RCbJuhAMgA25WMOap7k3w3XKw+HC8E702D43E6Kkc
         kSFOpH+WeS/1X7MibV7yGLvAMdkwoXUdaMbyWLU33u6DZWj2Bxm5ZH9WrN/HPFf2m3Ux
         2+ITubGyij/mXxftxC6Cp3Nlc7SYPiItssU9zDme5oSgu4noM5R4DTz72SB9H4wkf9K4
         7Hh3NMaSJXIPpUu7Gj21IDQWE6moayQ5i7+UMVqITx+zzm++WbkUl9DaBLJyt1Kw0WQh
         oCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783727029; x=1784331829;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PK5r5CSk1B7XeUp5Kcu4wbVddW3ItH3De22ETA07fPU=;
        b=d1dzp6rk/iF8dmJQOxoGJceBaSZWZdmUfexZMvY2+DwuwkOGBxUSqlHt8X0YsylQOP
         +0UiMTLqhsB3pK9kxTivbdNv27vPAEVRNMiynvfQl83Sb59gsX4USNQI040S6nWc8ELD
         YJAh56niV31UPsbq3iDGgUnRBY+i8PCRMifHPgfM3MwBZmg9O8G1/AlCjkbKaFXqn+RL
         9bsJtp/NQ2uiEGgZ48wIyuvE1xJAGjvylZtFDVq5P4P+EVmYzs1UX+lnkN7jX1wqASl0
         /xV5icXAQpAkZdYuzgO94b+DUBNllAwTgr2WfwVS7RgrXpRhnlzHNY6WTeAedNyUd7xL
         ja5Q==
X-Forwarded-Encrypted: i=1; AHgh+RrnxHRvTEpOU/A4pUNFsY+xSlCTaz7pdJeOCIhOHea4nynkYJFPdjH2aFk8DpQGx1ZqIO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKWu1+q6c/fDIFekU2pMkCN1Uce0hj9MQrYoSfbo4c4pW4MQbX
	fCpmIAbCuAfnGNXj7i1p0Ou5a4KgF4Sd6jZlnDBMhii8Y+kFsU5eDQUnHrDUp9NQOqs=
X-Gm-Gg: AfdE7cn/tzc5EfhHmK7qzKPbS6Q6024IoHLKuYLAXsb/AEsJ+ytCFb5HKl+HbAvqi3T
	Uy5ILRAG4FfMrOb9ISovfWeTlo/e4sDoeBnRXlfwvqyLYK3v9gLcd7ZaKwijN/hCYvJ6ZuPeo7W
	ofO5da7d1flHcnzuUMiNsoshkLsWLL/dCsbw+wO/VCbYsgdpp4/ZkPBJDBDVH9samO/V5lV9qyC
	370Mv+vbydW3uJmnHrBnl+Ti3FmnEmu2eOigOqJx1l28IdvLE7rYKnMhTZpVr/oPw0LCI6Qtbe2
	NTcJMuf+ecKtdL/7nPG2G+NhUgwukJyfVzq9tbebTRkPZhxTGnsslQgQDcFK1YzQeWimEPGZv+n
	FnJjvfxWR0n8B+op1DpAi6ijn73edLQyIT3lWtlKqz/1IhtMw0Ep9UPNF1okf+k52oaF+Jg==
X-Received: by 2002:a05:6a20:d489:b0:3bf:6c08:fba4 with SMTP id adf61e73a8af0-3c110ba29f4mr1116014637.56.1783727029145;
        Fri, 10 Jul 2026 16:43:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::6185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b9ca880fsm4980155eec.23.2026.07.10.16.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 16:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 19:43:47 -0400
Message-Id: <DJVAGK2ZNM3C.HAVUMJES6MGY@etsalapatis.com>
Cc: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>,
 <sched-ext@lists.linux.dev>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Require a BPF cpumask for
 bpf_cpumask_populate()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Admin"
 <main.kalliope@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
 <20260709182800.2037938-2-main.kalliope@gmail.com>
 <20260709183918.E42371F000E9@smtp.kernel.org>
 <DJV4TO9OH6AN.58C10SBPE8FF@gmail.com>
 <CAJZwKki8MwOmij3JZK=KnnO0hEUuxWA-iY=GK-TtvtVRvOkjOA@mail.gmail.com>
 <CAP01T76KdhEsbZj8yZN-yg5ogx99Ud87qqrhOGXTrX1ALdAgyg@mail.gmail.com>
In-Reply-To: <CAP01T76KdhEsbZj8yZN-yg5ogx99Ud87qqrhOGXTrX1ALdAgyg@mail.gmail.com>

On Fri Jul 10, 2026 at 4:34 PM EDT, Kumar Kartikeya Dwivedi wrote:
> On Fri, 10 Jul 2026 at 22:17, Admin <main.kalliope@gmail.com> wrote:
>>
>> On Fri, Jul 10, 2026 at 3:18=E2=80=AFPM Kumar Kartikeya Dwivedi
>> <memxor@gmail.com> wrote:
>> > Once this lands, please send a follow up to address this.
>>
>> Thanks. Patch 2/2 covers this, which updates the cpumask_common.h
>> declaration to take struct bpf_cpumask *, drops
>> the struct cpumask * casts from the existing populate tests, and adds
>> the borrowed-destination rejection test.
>
> Ah, my bad, makes sense. Let's just wait for others to ack it then.

Patchset looks good to me, and is consistent with the "mutation requires
passing bpf_cpumask, reading requires plain cpumask" throughout the
file.
