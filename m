Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064530171C
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307778; cv=none; b=iMqEdOSMfij3hSehOMtpm3GWi/J0fmaAJ/4aZp3aGkY0YHhbFGQ+Ws77rDq4zoSDHXYZbRHtCArLBMgHk8zhH7Zry5iMWCFVVR7or3wR5lVoa/YFcYx+s97InL0wmCnK7SylnAKJ2BesJkJNikFtxjqb2DvSicUdie2wD1bIVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307778; c=relaxed/simple;
	bh=4BZzTWmadIpPgdQresUeVaUcp5DGpz5V6zno6Q4Z1O8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=HlMZ3lpg9je4RJTiXIvoVk9+Nw/16xGUSVMpy3o9cYMv8BwzXm42axCWNmWyUQdWEOZ8M4qjgtejk49hT5ugOFFh58Sigi2AdYnC3mbh+T0T1BimL8ONiHUrRdxFDbVXM3ZkeLIm0o9FC3FtIdY+ZluY43ZTivI8VJ24wnW5K4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X3hsFQIu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X3hsFQIu"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47db714766aso954597f8f.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784307775; x=1784912575; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Lkj6Un2bLVNZ+vPuAfaPexv3e+Wv8C5O29PKU28JKqQ=;
        b=X3hsFQIuDdkqW3Oi3cPT+CoYCPPqroxq3JQpI6WjBnzK1pj7GskJtl1Q1RELU73XMT
         /3Qq04+DPhk5wZa6id5MZE3/7Qs89VYHZ7dEsPr/PvCJ6jBsYRC9FgvIeSbscgfZfflK
         6v+r3W0KSwQrxZRDtbZVoMpP2PgyF52/lMHp9Ug7rQT7Igw8hgH3xBfXReb2/Q5AF0oz
         95I5hWzN1CRBw02jKCw9W2Pn0lj6ZiL8JC+AnZ/UnfYJ5/67I2AJ7F8A+R/k6EhH8Ep6
         cYDGJVmwj5KgFvKGInqBU9tl+ub5UGEn9cdHtDBskzF/cBKODUDGHETK2ezayxIGG0mG
         8hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784307775; x=1784912575;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lkj6Un2bLVNZ+vPuAfaPexv3e+Wv8C5O29PKU28JKqQ=;
        b=alJPWUOtRh3mHCaRwZeRoRy99CGXWUPktVofn+gC+geOmfEHeu77+Tq5C3MlZDT91n
         ymVfJy9UMRwnOyEecI277GDhFCPYv8C1YO4xTZkD7pIij8mdJ0eKhPWXdfNPDkargnFf
         OzjJuYL0NZcPUS5CZMKTQZQF9bcEtBt8ZkyB8Q2eFL8zHLGwe6Z6C0uoBs9yFQxlNYsd
         IbybWBuZs+87YvJKZxXbN/DNCY5369EQTJpZ1PGrA9dm2Y+K5y5YmLtBhvzYhnSDsnPw
         g42ArBgArfki57PD1LHYtmkgi+8MxgX/FHJb1Qslk1ondyEZ0M7bDloV0tIFD61TmKMp
         w/Sw==
X-Gm-Message-State: AOJu0YxWUyr+qn+m4J0EERRlC8FkHzVkIdSYuvBkPao/S16IOfzunZi2
	3E3TJw4K0x0FmwcVe1Q1aZfTzJskCgeQ/Q7CTaUJNnEPrZedFjCjdvOAtXwus/ww6ec=
X-Gm-Gg: AfdE7cl+E5IdZruYoiHnrMHIPujngOLGe5KBmLeqzHj+CWU7kxphNY5YKdi8LokdFM+
	ZMQs1DH+y4vG7l008MSNmFvclgDH12JKQjhvZ//nlKQrNeFnGbe52jznA/ySq/pOaQio0Asgoto
	kSsXIAfb8mNcobnnEfo+1+gvWS8YfmOGwpe9Wxjef36CTNRf/vV2She9I+nN+lOaxvCyDXEiNbG
	X+7ota8okEZXsxajdXBSM0TJewHXmlywi5D7S1A7z4Fl0f9sSOq/pRWXJ/Lak7XuWXcleFZUU4C
	VaagiT20qXesHGSLX/Hmed85zhEhjxPmU1l+rv/6uYDxICixAzu5qFSZVvDGT/ilG8fR7aMU4sY
	gyF5TUuxa5FKt8EG+rvweVQZcuoJhjdMuUMLCJyQFED50/FT8MBmXM8gHr4x37AWN
X-Received: by 2002:a05:600c:c050:b0:495:499e:ec37 with SMTP id 5b1f17b1804b1-495499eed36mr34495265e9.18.1784307775060;
        Fri, 17 Jul 2026 10:02:55 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:c3e:eeab:5970:313d:2132])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef4275060sm14733597b3.23.2026.07.17.10.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 14:02:52 -0300
Message-Id: <DK10BEEYBU0Z.1T9AS7CA7LJID@suse.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Christian Brauner" <brauner@kernel.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH 2/4] selftests/bpf: Install resolve_btfids.test.o.BTF
 where the test expects it
X-Mailer: aerc 0.21.0-146-g87073a0460e3-dirty
References: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
 <20260710-selftests-bpf_fixes-v1-2-aa24dfd6f4f9@suse.com>
 <cebe82a7-203c-4b7e-a57f-0616850c58e3@linux.dev>
In-Reply-To: <cebe82a7-203c-4b7e-a57f-0616850c58e3@linux.dev>

On Thu Jul 16, 2026 at 6:10 PM -03, Ihor Solodrai wrote:
> On 7/10/26 3:09 PM, Ricardo B. Marli=C3=A8re wrote:
>> prog_tests/resolve_btfids.c looks for "resolve_btfids.test.o.BTF" relati=
ve
>> to the running test_progs binary. resolve_btfids always writes
>> <obj.path>.BTF next to the object it processes, so building
>> resolve_btfids.test.o also produces resolve_btfids.test.o.BTF in the bui=
ld
>> output directory as a side effect.
>>=20
>> INSTALL_RULE never carries it over: it is not part of TEST_FILES,
>> TEST_GEN_FILES or TRUNNER_EXTRA_FILES, and it is not copied by the *.bpf=
.o
>> rsync used for TEST_INST_SUBDIRS. After "make install", every flavor of
>> test_progs, including the default one, fails with "Failed to load BTF fr=
om
>> resolve_btfids.test.o.BTF", even though the file built fine and BTF ID
>> resolution itself works correctly.
>>=20
>> Install it next to the rest of the per-flavor build output, using an
>> explicit rsync in INSTALL_RULE like the one already used for bpftool.
>>=20
>> Fixes: 522397d05e7d ("resolve_btfids: Change in-place update with raw bi=
nary output")
>> Signed-off-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>
>> ---
>>  tools/testing/selftests/bpf/Makefile | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index 47911c9b4977..7260d672acf7 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -1057,10 +1057,11 @@ override define INSTALL_RULE
>>  	$(DEFAULT_INSTALL_RULE)
>>  	@mkdir -p $(INSTALL_PATH)/tools/sbin
>>  	@rsync -a $(if $(PERMISSIVE),--ignore-missing-args) $(TRUNNER_BPFTOOL)=
 $(INSTALL_PATH)/tools/sbin/
>> +	@rsync -a $(if $(PERMISSIVE),--ignore-missing-args) $(OUTPUT)/resolve_=
btfids.test.o.BTF $(INSTALL_PATH)/
>
> I think you can squash patches #1 and #2 into a single "Fix make
> install target" patch.
>
> pw-bot: cr
>
> nit: This hardcodes the filename, and even though we only have one
> test that needs .BTF currently, you could add *.BTF to the loop:
>
> 	$(OUTPUT)/$$DIR/*.bpf.o $(OUTPUT)/$$DIR/*.BTF
>
> Then any future test that consumes a raw .BTF gets installed for free.

Good call! I'll prepare v2. Thanks for the review :)

>
>>  	@for DIR in $(TEST_INST_SUBDIRS); do				  \
>>  		mkdir -p $(INSTALL_PATH)/$$DIR;				  \
>>  		rsync -a $(if $(PERMISSIVE),--ignore-missing-args)	  \
>> -			$(OUTPUT)/$$DIR/*.bpf.o				  \
>> +			$(OUTPUT)/$$DIR/*.bpf.o $(OUTPUT)/$$DIR/resolve_btfids.test.o.BTF \
>>  			$(INSTALL_PATH)/$$DIR;				  \
>>  	done
>>  endef
>>=20


