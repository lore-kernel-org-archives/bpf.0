Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA6BA27
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 00:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710291394; cv=none; b=Fr9Y/f7qphxOY+iRlC7ky7wef6VDN4mro442FO67qY5/Bedc32TgtBpI2OFT+QaaK97Uz1R3+pmkj6BFCxUHduxaCn7N9L6MU7F/WLyrgeNy21cCyT8wUj/iqUXQZwkobHti+iIRJXJ9VCH9+wNRrfFpK1SlNPpSiSJrPOpSPpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710291394; c=relaxed/simple;
	bh=kgWmLdlhkaRK8Bje8cvpNIt6WHODBwbGzUvyQ+8yqhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Paxqg047wQHPA6yTeJJGCj8JO/16+cLMPkjKcC15S+H1IsGpppjEl5qNhAYByWLTbuTiTgWAMSj1hjgVvZC0rDXQJpI80Q/LDAMB+zmoGBSbBoR6duEAB4dFvhoQImJjBDgmxPfwQNeLaZhjs52IHho3fvHQMS96NONjh6WFoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDEg0yAU; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDEg0yAU"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso5691422276.0
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 17:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710291390; x=1710896190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cymx4Ze939PzKNlItj5Hbdkge/F3QDyWSisJyCS76Xg=;
        b=RDEg0yAUhq9Lc8efv3z6rFwgWf82Iqdah6gfw1qq1Br4SMEWSHOrK3ISxG2p4d+lsU
         rbSTASC4wt85LNG2vIPXXIBU4ED7ZNmLMAAW5eeaD62Jc3LdQ0oEkX96aRr3wXODquwE
         sxf6QT6lEjxcMvuRcAdmykyY2e9G1bCk21Yn7ojXKvGWoFJuK3gXMtWCVMU/xC2BkT7W
         sbQTl9nE9IR5/hE66uczTkRdy5m3wUahebk9eeeL2nvInbxqvBSoXbkZOeKJRT/3y8Y6
         WapjbKTCbmaFKWpJ5u9y8bh3TWLcpaZfsqrA903+bH/hjdvwMUvftDbPajPyEqtNNFW1
         PMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710291390; x=1710896190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cymx4Ze939PzKNlItj5Hbdkge/F3QDyWSisJyCS76Xg=;
        b=r5fhOIEg89tfwV858lVcj0UB4fdjdDpS5dlyi2MnIyepe+XgBqEWj26YaY19Trjpkg
         8nqF56ovD2b8p2fTxwv5WH/9Sl4HS0RoJ/gu09V5YTWmG7z2bg54ymhUwOMjgtS2ggO+
         0wwm5ZF6RYx3S4ZyOCm2lOspOj5LFdxS7wlGQX1n/KSdOxzPNnKse0ILFu1RyCkrSd1V
         xBzxxBGuvuP4hkBgmNg+9IpP+X4bcSk8WIeXrPUXa0FFWqI+ephElgSM1ZSU4dPu9RJT
         8uXFb6gcPcJXrjJ60k9X+GGFcLzLuNF5QVu3bdd/KIdx+a+HdfZT6+jpo3DAmvLMbAc+
         RGWQ==
X-Gm-Message-State: AOJu0YwqYt2sRsL+wOtkpqxq3dbPYdD/0cWdWPm/KuAKYVMoWF1gd3u+
	jymOeiV1wNjECPJ7cmsDF/O52h/k6p8xE0GlENLJIVegKAQnDyPz
X-Google-Smtp-Source: AGHT+IEQzxmri6P0Syni3e+uDVn74C6YosB8BEU0g2pCQ6QBCiI8hwL5zCsRfJ14ePAAVr3NLz7lag==
X-Received: by 2002:a25:8208:0:b0:dcd:3e78:d080 with SMTP id q8-20020a258208000000b00dcd3e78d080mr1093096ybk.4.1710291390322;
        Tue, 12 Mar 2024 17:56:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a9ce:8a39:867c:8f30? ([2600:1700:6cf8:1240:a9ce:8a39:867c:8f30])
        by smtp.gmail.com with ESMTPSA id p133-20020a25d88b000000b00dcbbea79ffcsm2018008ybg.42.2024.03.12.17.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 17:56:29 -0700 (PDT)
Message-ID: <cc07c8ad-d07c-4314-8f4f-ec1fe913b005@gmail.com>
Date: Tue, 12 Mar 2024 17:56:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Ensure libbpf skip all-zeros
 fields of struct_ops maps.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240312183245.341141-1-thinker.li@gmail.com>
 <20240312183245.341141-3-thinker.li@gmail.com>
 <CAEf4BzYyDV5MAjB+0Jj64Fr6AqPg+JS_mHc2rGNovFPAHjxM2Q@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzYyDV5MAjB+0Jj64Fr6AqPg+JS_mHc2rGNovFPAHjxM2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/12/24 16:10, Andrii Nakryiko wrote:
> On Tue, Mar 12, 2024 at 11:32 AM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> A new version of a type may have additional fields that do not exist in
>> older versions. Previously, libbpf would reject struct_ops maps with a new
>> version containing extra fields when running on a machine with an old
>> kernel. However, we have updated libbpf to ignore these fields if their
>> values are all zeros or null in order to provide backward compatibility.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   .../bpf/prog_tests/test_struct_ops_module.c   | 35 +++++++++++++++++++
>>   .../selftests/bpf/progs/struct_ops_module.c   | 13 +++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> index ee5372c7f2c7..e0d9ff75121b 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> @@ -93,9 +93,44 @@ static void test_struct_ops_load(void)
>>          struct_ops_module__destroy(skel);
>>   }
>>
>> +static void test_struct_ops_not_zeroed(void)
>> +{
>> +       struct struct_ops_module *skel;
>> +       int err;
>> +
>> +       skel = struct_ops_module__open();
>> +       if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
>> +               return;
>> +
>> +       bpf_program__set_autoload(skel->progs.test_3, false);
> 
> maybe mark test_3 program in progs/struct_ops_module.c as default
> not-autoload (SEC("?struct_ops/test_3")), so you don't have to set
> this to false everywhere?

Sure! I forgot we have this new feature.

> 
>> +
>> +       err = struct_ops_module__load(skel);
>> +       struct_ops_module__destroy(skel);
>> +
>> +       if (!ASSERT_OK(err, "struct_ops_module_load"))
>> +               return;
>> +
>> +       skel = struct_ops_module__open();
>> +       if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_not_zeroed"))
>> +               return;
>> +
>> +       bpf_program__set_autoload(skel->progs.test_3, false);
>> +
>> +       /* libbpf should reject the testmod_zeroed since the value of its
>> +        * "zeroed" is non-zero.
>> +        */
>> +       skel->struct_ops.testmod_zeroed->zeroed = 0xdeadbeef;
>> +       err = struct_ops_module__load(skel);
>> +       ASSERT_ERR(err, "struct_ops_module_load_not_zeroed");
>> +
>> +       struct_ops_module__destroy(skel);
>> +}
>> +
>>   void serial_test_struct_ops_module(void)
>>   {
>>          if (test__start_subtest("test_struct_ops_load"))
>>                  test_struct_ops_load();
>> +       if (test__start_subtest("test_struct_ops_not_zeroed"))
>> +               test_struct_ops_not_zeroed();
>>   }
>>
>> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
>> index 026cabfa7f1f..d7d7606f639c 100644
>> --- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
>> +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
>> @@ -54,3 +54,16 @@ struct bpf_testmod_ops___v2 testmod_2 = {
>>          .test_1 = (void *)test_1,
>>          .test_2 = (void *)test_2_v2,
>>   };
>> +
>> +struct bpf_testmod_ops___zeroed {
>> +       int (*test_1)(void);
>> +       void (*test_2)(int a, int b);
>> +       int (*test_maybe_null)(int dummy, struct task_struct *task);
>> +       int zeroed;
>> +};
>> +
>> +SEC(".struct_ops.link")
>> +struct bpf_testmod_ops___zeroed testmod_zeroed = {
>> +       .test_1 = (void *)test_1,
>> +       .test_2 = (void *)test_2_v2,
>> +};
> 
> We should also test the case where we have local ops definition with
> incompatible callback function signature (e.g., extra argument or
> something). Test then would update the program pointer (through
> skeleton's shadow type) to a compatible implementation.
> 
> Can you please add a test like that? Because the goal is to have a
> single struct_ops definition, if possible, and adjust it at runtime to
> make it compatible with the old kernel, let's have a small demo of
> this working.

Do you want to check signatures at libbpf? Or you just want a small
demo?

For extra arguments, IIRC, the verifier should reject the program if the 
program did access these arguments since it accesses memory beyond the 
last byte of the context. Doing extra checking at libbpf can provide 
better error messages if that is what you want.

If a program never accesses an extra argument, it should be allowed.(?)
WDYT?


> 
>> --
>> 2.34.1
>>
