Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9502FC6FA99
	for <bpf@archiver.kernel.org>; Wed,  8 Mar 2023 01:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCHBZF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 7 Mar 2023 20:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCHBZF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 20:25:05 -0500
Received: from out-25.mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F7A38E86
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 17:25:02 -0800 (PST)
Message-ID: <8854d3ae-3288-3e98-33fd-9bd015a78173@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678238701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lYfDl3x71BoIKh4B2topmgc5dRp0m7mm9+FGwjP2RfQ=;
        b=diBeDxYPv2O264sJR0a0rPtD3Kn3u87Sn2Z66juifB3w330SWSZgGfBclc+Yn2qT0GOcAw
        cri6+oPqorPmMAmWx9Rx9zlS1xoDfb+QB7axS1hOfuv8QZbiW94YwxlhL6iIq22aBNJFXY
        M9z9bxJVMxSvK4Gfzhd2t4g1qrJJ5Rc=
Date:   Tue, 7 Mar 2023 17:24:58 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 14/16] selftests/bpf: Replace CHECK with ASSERT
 in test_local_storage
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20230306084216.3186830-1-martin.lau@linux.dev>
 <20230306084216.3186830-15-martin.lau@linux.dev>
 <CAEf4BzYn4CMhNLko5E1HmhP5BeeeVWeUqWzbOjuDcbSgo4nBTA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAEf4BzYn4CMhNLko5E1HmhP5BeeeVWeUqWzbOjuDcbSgo4nBTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/7/23 5:15 PM, Andrii Nakryiko wrote:
>> @@ -60,36 +58,32 @@ static bool check_syscall_operations(int map_fd, int obj_fd)
>>
>>          /* Looking up an existing element should fail initially */
>>          err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val, 0);
>> -       if (CHECK(!err || errno != ENOENT, "bpf_map_lookup_elem",
>> -                 "err:%d errno:%d\n", err, errno))
>> +       if (!ASSERT_ERR(err, "bpf_map_lookup_elem") ||
>> +           !ASSERT_EQ(errno, ENOENT, "errno"))
> 
> all libbpf APIs since v1.0 always return actual error number directly,
> so no need to check errno anymore, you can simplify this further
> 
>>                  return false;
>>
>>          /* Create a new element */
>>          err = bpf_map_update_elem(map_fd, &obj_fd, &val, BPF_NOEXIST);
>> -       if (CHECK(err < 0, "bpf_map_update_elem", "err:%d errno:%d\n", err,
>> -                 errno))
>> +       if (!ASSERT_OK(err, "bpf_map_update_elem"))
>>                  return false;
>>
>>          /* Lookup the newly created element */
>>          err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val, 0);
>> -       if (CHECK(err < 0, "bpf_map_lookup_elem", "err:%d errno:%d", err,
>> -                 errno))
>> +       if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
>>                  return false;
>>
>>          /* Check the value of the newly created element */
>> -       if (CHECK(lookup_val.value != val.value, "bpf_map_lookup_elem",
>> -                 "value got = %x errno:%d", lookup_val.value, val.value))
>> +       if (!ASSERT_EQ(lookup_val.value, val.value, "bpf_map_lookup_elem"))
>>                  return false;
>>
>>          err = bpf_map_delete_elem(map_fd, &obj_fd);
>> -       if (CHECK(err, "bpf_map_delete_elem()", "err:%d errno:%d\n", err,
>> -                 errno))
>> +       if (!ASSERT_OK(err, "bpf_map_delete_elem()"))
>>                  return false;
>>
>>          /* The lookup should fail, now that the element has been deleted */
>>          err = bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val, 0);
>> -       if (CHECK(!err || errno != ENOENT, "bpf_map_lookup_elem",
>> -                 "err:%d errno:%d\n", err, errno))
>> +       if (!ASSERT_ERR(err, "bpf_map_lookup_elem") ||
>> +           !ASSERT_EQ(errno, ENOENT, "errno"))
> 
> same here and probably in other places (I haven't checked everything)

Ack. will simplify.
