Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757C4A99C9
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365165; cv=none; b=IRT7fA/OxvS7+0sZ88bSFG2As6qur6YHOXJYubK9Dz9uRxJohoY6+hSXJrnzKgn7IFOihlV/6+EqhIIIiOvSd8+Bh5d9nqmE3/qdP5VkkTnbzuNJnD6J1zt6b6i6JIx204R5OcEgqmvg7jUWQdxqEDjlzOi0A1/VJJTMQWj8u3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365165; c=relaxed/simple;
	bh=i6OeUmnuMF2IwjK0QDvdcohipAXwd3mtUqdCCx1H/H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BItklxYEkL+FN8y4lHvJyXmAuArcnuE2SAFIt5oq+RgOVS91iTue4qn7WH3j7lN8geEOPEm76YlN53rQurD6RsnbwpRcwLBxFV5ALnhvb5SskUgXqFN7rciw5sCx7MzjG4B+X8sTig02cybnmAoJ3VCSB6OU9J6HzJ9xnpP4zYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rQwNyupC; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rQwNyupC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=lD12SBt769Hy1/p+350JlxEsSEvnOOPb1BaynLX1Kbg=; b=rQwNyupCR31qhsvgCa+fy1fyyR
	gC7Pl3RFsYyWk6+X/zRzZbXPXWsMkxgjJzrwPtns4j8salsYqOavTJ/iAFCXrQZmdVv/wkMyUjlPy
	dUxoZll8SnaGmP0Ie8ndR9MmKcfICKMS9SVZs2yTjEaxdpxZ2+2BKm26uUDKk85Tg/6wEPIxf9237
	b6sFGnoE92O4ss5QD8GPZ2mQ+IU+ha7vq38C59y5OtNIsDI/4vURZaTYrApa5arMQyY68WXjzochw
	hKLBe+ely8JT5AscgFaO49ZNxyn48z9jUV+H1oQTX2sTC2oNuGMg1VW83K2K+DMt+/+s93lU1i7xp
	ziK7XZ9g==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x1n9n-0001OB-07;
	Wed, 02 Sep 2026 17:45:47 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1x1n9l-000GaA-32;
	Wed, 02 Sep 2026 17:45:45 +0200
Message-ID: <4d438f3a-73c2-44ec-9d72-cbf554900d27@iogearbox.net>
Date: Wed, 2 Sep 2026 17:45:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Test terminal gotox
 instructions
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, rlmenge@gmail.com, hargar@linux.microsoft.com,
 apais@microsoft.com
References: <20260901170144.70453-1-sidchintamaneni@gmail.com>
 <20260901170144.70453-2-sidchintamaneni@gmail.com>
 <apcRnSj7dVW1Dlsr@mail.gmail.com>
 <CAE5sdEgXd3AcJyRO6zdNEtFs-bwXRWzbA_qMR=Xdi9qA_NZvJQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAE5sdEgXd3AcJyRO6zdNEtFs-bwXRWzbA_qMR=Xdi9qA_NZvJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28111/Wed Sep  2 08:24:01 2026)

On 9/1/26 7:55 PM, Siddharth Chintamaneni wrote:
> On Tue, 1 Sept 2026 at 10:45, Anton Protopopov <a.s.protopopov@gmail.com> wrote:
>> On 26/09/01 05:01PM, Siddharth Chintamaneni wrote:
>>> Add tests that place gotox at the end of the main program and a
>>> subprogram, with each jump-table target preceding the gotox instruction.
>>> This tests gotox as a valid non-fallthrough terminal instruction.
>>>
>>> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
>>> ---
>>>   .../selftests/bpf/progs/verifier_gotox.c      | 42 +++++++++++++++++++
>>>   1 file changed, 42 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
>>> index 5b18c9a27717..cfb5b648891f 100644
>>> --- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
>>> +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
>>> @@ -47,6 +47,48 @@ DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_src_reg,      BPF_REG_1, 0, 0, __fa
>>>   DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_off, BPF_REG_0, 1, 0, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
>>>   DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
>>>
>>> +#define DEFINE_TERMINAL_GOTOX_PROG(NAME, BASE)                       \
>>> +     __naked void NAME(void)                                 \
>>> +     {                                                       \
>>> +     asm volatile ("                                         \
>>> +     .pushsection .jumptables,\"\",@progbits;                \
>>> +jt0_%=:                                                      \
>>> +     .quad ret0_%= - " BASE ";                               \
>>> +     .size jt0_%=, 8;                                        \
>>> +     .global jt0_%=;                                         \
>>> +     .popsection;                                            \
>>> +                                                             \
>>> +     r0 = jt0_%= ll;                                         \
>>> +     r0 = *(u64 *)(r0 + 0);                                  \
>>> +     goto end_%=;                                            \
>>> +ret0_%=:                                                     \
>>> +     r0 = 0;                                                 \
>>> +     exit;                                                   \
>>> +end_%=:                                                      \
>>> +     .8byte %[gotox_r0];                                     \
>>> +"    :                                                       \
>>> +     : __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,   \
>>> +                                         BPF_REG_0, 0, 0, 0))        \
>>> +     : __clobber_all);                                       \
>>> +     }
>>> +
>>> +SEC("socket")
>>> +__success __retval(0)
>>> +DEFINE_TERMINAL_GOTOX_PROG(jump_table_terminal_gotox, "socket")
>>> +
>>> +static __noinline __used
>>> +DEFINE_TERMINAL_GOTOX_PROG(terminal_gotox_subprog, ".text")
>>> +
>>> +SEC("socket")
>>> +__success __retval(0)
>>> +__naked void jump_table_terminal_gotox_subprog(void)
>>> +{
>>> +     asm volatile ("                                         \
>>> +     call terminal_gotox_subprog;                            \
>>
>> I wonder if robot will reply the same as for v2.
>>
>> The suggestion was to do
>>
>>      call terminal_gotox_subprog1
>>      call terminal_gotox_subprog2
>>
>> such that subprog1 is not the last piece of loaded prog...
> 
> I missed this part! Can I reply the diff to this thread? or does it
> require a new revision?
Please send a v4 given this needs to go through BPF CI.
