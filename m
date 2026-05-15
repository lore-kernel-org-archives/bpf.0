Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A06B3909B3
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875789; cv=none; b=jRFD99cMwHBcXtGCKhollHRafXIJHnIihau0+BrfZvT+YvfzCQkntU4rWd+MFwwqUSlDexjyMgMPYj5vp/9rFObrCO+J64FZCFvdO3PVrYfInlRc3KWCyq4a61gnohnimA4g3Yf6yBuGlteAZrsvXGkEQ3bQVkSun/iEepgpjvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875789; c=relaxed/simple;
	bh=eHYdQTeQyDvfFdCM0KGLCYSBT9jr3H9LQqqjbauCO+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dpum2biCijz5x/UzWrzlVMi3BP72diS3IuATaP5XhKOIp9dS+KOKxtpA/xCbQZkgpqBfLNfzKSChxOBwsHnom7yWMOmVbhBw5oGpeFwaYbNLMEG3sEEwbnurjcM/AJ++j0Zpq+egyzaeoPZ5NiLDrc44300rF22/w5Tfx3sF/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQpcJwdP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQpcJwdP"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso1023295e9.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778875786; x=1779480586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+S5wVxWfcKMGbz7T+itvslblDRSu63n1AJM/TQSrJjM=;
        b=PQpcJwdPNespfWvrNAluoumbdUKgNMJWoHYe4aq1REMFeJlB2q+9yPexMCleJbz9JL
         Ecvaex9Te7inDQZ1mUy2lb/JrSMh8Q7lpE4cOK/70TGxz4o83VNjI4N/BQT7h0soaRQ/
         h4uzogazxyEOw0WebDE16WPfs7bBfuk54TeDi5c/V/C5WvtcnV0ILxVru9EIYh0bcUqG
         VvpzcOEevXjqDLir5FVr4jRf5VoKoxw5GL8iETUXfIN/POF+ek5Jiib7LTEWH902Jnuo
         vq9kh0G6Cgu3pX7Vd3kuCrWTySy8rIvrMlPzs2jlXqE2Q2y5vY3cU9XmPdYymnr7/sxL
         hs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778875786; x=1779480586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+S5wVxWfcKMGbz7T+itvslblDRSu63n1AJM/TQSrJjM=;
        b=IdYocmC7mvg1LP7MqqINHKzL6+nE6G0Jc6/xU+uFuXoOwjJaf7Kzyc5Hihkkk1C7Kd
         1C2klZuTdAIye2BOW4O0FOlkqSTkXiAhkpTQKEk+35Sx2BVd6OQdLf0TYsG/eH3mCyJN
         NI/Twwg7xI6cFZpH8p2fKI2zg7xlLf9bENfjkWi2tLPIcWGFDDgZDOGjIIeIw6jFU8u0
         /YBpH8YVWoqdoEhv3fMzJDFWSJkzp6beT0GJAjHohgz2NJx1Jlc/fiJCa35KlML4hmnh
         soctGufoJNWduyZ6IUDlRbgeFwo5nCD3C9OgSKib+wc6Jyb8v4o/I2nHhVWsh5T/6R2x
         aj7g==
X-Gm-Message-State: AOJu0YwCy6LgMgKGKTls3SIuUiHgcBIiNKjDA97P7RTlnw0TP0AYu2Rf
	BCNGUxJ06nvAG6MGjN3AsUs9uPAAgzDYrMQ0pvF1mq9pd0S4qpgvNZNa
X-Gm-Gg: Acq92OEU7NJWEEOxxcwg8kr1heSX+/hShrb/fD6HIFHUhUVxxn2qctTkvxi3leHI8WB
	+IkXFWYI/UMbVd8gQF4ToxN+JjfdZQDiMi98AqWQaWzjWW47nmvnF9n5nMzy4sWJQt/b1z5nXxu
	95wOkmHI1l6vvSzRbR3tJKfb6JLwxaz5vGijeFMkFMv1fJKPAMfLLzRrjC3hc9WEYycSHLTLbpz
	aEeg/JLYYL3g8SLOkKRiipnqeDh/46vDvQgEsMc624o3trOCEZ2u4TVRff1hsvA2TYdvfMjex2H
	UD8Mi2NEHOMvpysi0xmPCIVP2/8b8qgc2BtOCoVIXbsOnrpU/gTbs8NhE6ZoEWlWMrzt9/A6lX6
	UqMBkIUK2hM4xVRv1NQZR/V6NTX5fqurKH2HMED2y6Vif3BuPaTcdqp/zegdY7gOfAAPb/3KW0n
	CtaRgy4Cni5qig6rVRvpytOZBQldkUMfOEOhxyszV274ft63do3CJApTavXlMcRSUYl/ZuZ2EXR
	BIgdJDcNgo=
X-Received: by 2002:a05:600c:34d4:b0:48f:e230:c3fa with SMTP id 5b1f17b1804b1-48fe6626a58mr75827145e9.32.1778875785529;
        Fri, 15 May 2026 13:09:45 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694fbfsm149747125e9.6.2026.05.15.13.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 13:09:45 -0700 (PDT)
Message-ID: <8b2d626f-9fe2-47fc-830d-a26183913d77@gmail.com>
Date: Fri, 15 May 2026 21:09:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add test for tracepoint
 btf_ids tracefs file
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260515-generic_tracepoint-v1-3-aa619fa94132@meta.com>
 <20260515183659.31941C2BCB0@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260515183659.31941C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/26 7:36 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Missing test environment check for `bpf_testmod` module causes spurious test failures.
> - [Medium] Out-of-bounds array reads and cascading failures due to non-aborting assertions and missing length checks.
> --
> 
> commit 1c2fbe8e9b6c6c1082b4ae630c67ceb3b5db79b5
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> 
> selftests/bpf: Add test for tracepoint btf_ids tracefs file
> 
> This commit adds a selftest to verify that the BTF IDs exposed in the
> tracefs btf_ids file for a module tracepoint match the expected FUNC_PROTO
> and STRUCT representations. It uses the bpf_testmod_test_read tracepoint
> to exercise the module/split-BTF path.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c b/tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c
> 
> [ ... ]
> 
>> +void test_tp_btf_ids(void)
>> +{
>> +	const struct btf_type *proto_t, *rec_t;
>> +	const struct btf_param *params;
>> +	const struct btf_member *members;
>> +	struct btf_ids_info info;
>> +	struct btf *vmlinux_btf, *btf;
>> +	const char *name;
>> +	int err;
>> +
> 
> Since this test relies on bpf_testmod_test_read from the bpf_testmod.ko
> kernel module, should there be a check for env.has_testmod here? 
> 

yes

> Without it, if the module is not loaded, the test might fail with a missing
> tracefs directory instead of gracefully skipping via test__skip().
> 
>> +	err = read_btf_ids(&info);
>> +	if (!ASSERT_OK(err, "read btf_ids"))
>> +		return;
> 
> [ ... ]
> 
>> +	/*
>> +	 * raw_btf_id should be the FUNC_PROTO of __bpf_trace_<call>:
>> +	 *   void *__data, struct task_struct *task,
>> +	 *   struct bpf_testmod_test_read_ctx *ctx
>> +	 */
>> +	proto_t = btf__type_by_id(btf, info.raw_id);
>> +	if (!ASSERT_OK_PTR(proto_t, "raw type_by_id"))
>> +		goto out;
>> +	if (!ASSERT_TRUE(btf_is_func_proto(proto_t), "raw is FUNC_PROTO"))
>> +		goto out;
>> +	ASSERT_EQ(btf_vlen(proto_t), 3, "func_proto arg count");
>> +
>> +	params = btf_params(proto_t);
>> +	ASSERT_STREQ(param_name(btf, &params[0]), "__data", "arg0 name");
>> +	ASSERT_STREQ(param_name(btf, &params[1]), "task", "arg1 name");
>> +	ASSERT_STREQ(param_name(btf, &params[2]), "ctx", "arg2 name");
> 
> Does this code risk reading out of bounds if btf_vlen(proto_t) is less than 3?
> 
> The ASSERT_EQ macro logs a failure but does not inherently abort the
> function execution. Should this be wrapped in a conditional check, such as
> if (!ASSERT_EQ(...)) goto out, to prevent accessing params[2] if the length
> is too small?
> 

ok, I'll apply all these in v2

>> +
>> +	/*
>> +	 * tp_btf_id should be STRUCT trace_event_raw_<call> with the
>> +	 * fields declared by TP_STRUCT__entry plus the common header.
>> +	 */
>> +	rec_t = btf__type_by_id(btf, info.tp_id);
>> +	if (!ASSERT_OK_PTR(rec_t, "tp type_by_id"))
>> +		goto out;
>> +	if (!ASSERT_TRUE(btf_is_struct(rec_t), "tp is STRUCT"))
>> +		goto out;
>> +	name = btf__name_by_offset(btf, rec_t->name_off);
>> +	ASSERT_STREQ(name, "trace_event_raw_bpf_testmod_test_read",
>> +		     "tp struct name");
>> +
>> +	members = btf_members(rec_t);
>> +	ASSERT_STREQ(member_name(btf, &members[0]), "ent", "field0 name");
>> +	ASSERT_STREQ(member_name(btf, &members[1]), "pid", "field1 name");
>> +	ASSERT_STREQ(member_name(btf, &members[2]), "comm", "field2 name");
>> +	ASSERT_STREQ(member_name(btf, &members[3]), "off", "field3 name");
>> +	ASSERT_STREQ(member_name(btf, &members[4]), "len", "field4 name");
> 
> Similarly, is it necessary to assert btf_vlen(rec_t) and conditionally jump
> to out if it is too small before accessing members[0] through members[4]?
> 
> If the structure layout changes or is malformed, this might read adjacent
> BTF data.
> 
>> +out:
>> +	btf__free(btf);
>> +	btf__free(vmlinux_btf);
>> +}
> 

