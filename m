Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354AF43CE56;
	Tue,  8 Sep 2026 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911307; cv=none; b=mqIg1wgwcTZPlumiPaYnpkNfDuklOvZJVNYqbJspFU/MPkb28ibHv2aT7NEKpkQzoopASUHpM8zLMhAQQXxQlfe29AJjbQloLqqb1D9TaVMRcnt/HLcI5tJ5OU/Mr1nFx8BhD43Ul4k1FVfpcm8mfX8N7S4GUSevqgTNgedQqU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911307; c=relaxed/simple;
	bh=X/wdeUoQL2g3SEPUcRuHWZSH2cwrvyCRMSFtyrgAhjA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=buVrf+1dQN9l8TrvGqY3Yw856QwC5yIVhiUdjEObYkipNM7AZKNCnATcbRPnycQ15Qq1G91rJHoYvRDLMDjkMw4IpyzicZI2SNhc6xWLmUq5ZnkENPAuJ6fMrYq10A2v6ZVI3/p8+9tcyfcYSTFzAP6UQusR5QKI7eE7EDTsY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2S5iUmC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2S5iUmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052E61F00A3A;
	Tue,  8 Sep 2026 23:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788911305;
	bh=pBRRw/WQSZq5lErQGcrKbzP/kPv28lIFFHDhWtQ5g3Y=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=m2S5iUmC9BE4oUJ8V6RXflaXDDOHWZNjHc/QCZtEJYKyWAldsrO8akKbMkbDXtqix
	 7JKPimdQ/OfI25/9K3qjgXrDYVnWNfRRk2IadNqcG86lvlFiKpfJdoQutbxOD6Kc4d
	 h1SwwQRATh6UzlJaOWmKQcCG/yZY0lBOBO4ViQ/cpFrkmLIqz9TKykrwluF/th7CR7
	 +TzV4LbLzAfZQaHjXxLbXswnrsF8EAahUtW4fonLBn8gWLB/+a/iVgcPWkx9zXtKf8
	 xZsJSY2eRoAXtg7/D6P1Kk4wGEOX/sf7TQrZysJwDfne/GgTrXDTsEnvSEIZPHbWdk
	 ICQyZligUe60w==
Message-ID: <f8c3cfba-740c-4a57-ad65-d419fa5b6cf7@kernel.org>
Date: Wed, 9 Sep 2026 00:48:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpftool: Skip non-autoload programs when
 generating light skeletons
To: bot+bpf-ci@kernel.org, tweek@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, shuah@kernel.org, kpsingh@kernel.org,
 leon.hwang@linux.dev, emil@etsalapatis.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, ihor.solodrai@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20260908065529.901593-1-tweek@google.com>
 <70e2a2f4354a7eb6208944e1ab2c13dadcb8b78cdbe2888ad4471124b1cc81b7@mail.kernel.org>
Content-Language: en-GB
In-Reply-To: <70e2a2f4354a7eb6208944e1ab2c13dadcb8b78cdbe2888ad4471124b1cc81b7@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2026 17:01, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
>> index d0a36f442db7..1cdecf3e4fa5 100644
>> --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
>> +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> 
> [ ... ]
> 
>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>> index a50540ef6521..0fcfe20ff515 100644
>> --- a/tools/bpf/bpftool/gen.c
>> +++ b/tools/bpf/bpftool/gen.c
>> @@ -583,6 +583,9 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
>>  	bpf_object__for_each_program(prog, obj) {
>>  		const char *tp_name;
>>
>> +		if (!bpf_program__autoload(prog))
>> +			continue;
>> +
>>  		codegen("\
>>  			\n\
>>  			\n\
> 
> [ ... ]
> 
>> @@ -1339,6 +1348,8 @@ static int do_skeleton(int argc, char **argv)
>>  		map_cnt++;
>>  	}
>>  	bpf_object__for_each_program(prog, obj) {
>> +		if (use_loader && !bpf_program__autoload(prog))
>> +			continue;
>>  		prog_cnt++;
>>  	}
> 
> Can the autoload flag change between when this check runs and when
> codegen_attach_detach() checks it?
> 
> Looking at the code flow, do_skeleton() samples bpf_program__autoload() here
> before calling bpf_object__load(), but codegen_attach_detach() and
> codegen_destroy() (which also check autoload at gen.c:586, 635, 654, and 686)
> run inside gen_trace() after bpf_object__load() completes.
> 
> In tools/lib/bpf/libbpf.c, bpf_object__load() ->
> bpf_object_prepare() modifies prog->autoload for struct_ops programs:
> 
> 1. bpf_object__init_kern_struct_ops_maps() (libbpf.c:1251, 1290) sets
>    st_ops->progs[i]->autoload = false when the member is missing from kernel
>    BTF or the slot was replaced/NULLed.
> 
> 2. bpf_object_adjust_struct_ops_autoload() (libbpf.c:1166) sets
>    prog->autoload = should_load for programs referenced by struct_ops maps,
>    which can flip SEC("?struct_ops/...") programs from false back to true when
>    the referencing map has autocreate set.
> 
> For the false->true case (SEC("?struct_ops/foo") with an autocreated map):
> do_skeleton() omits both the progs and links struct fields, but
> codegen_attach_detach()/codegen_destroy() then emit attach functions
> referencing skel->progs.foo.prog_fd and skel->links.foo_fd, which weren't
> declared.
> 
> For the true->false case (plain SEC("struct_ops/foo") whose member is missing
> from kernel BTF): the fields are emitted but attach/detach/destroy skip the
> program, and the loader doesn't reserve a prog_fd slot for it, so subsequent
> program FDs get written into preceding fields.
> 
> Would it work to sample autoload once and reuse that decision, or to move the
> struct field emission after bpf_object__load()?

It looks like both Sashiko and the bpf-ci bot raised valid concerns.
Here, it's probably cleaner to move the struct field emission after
bpf_object__load()? Seems a bit more involved though, we'd need to move
these struct field emission to gen_trace() for the use_loader case, or
move bpf_object__load() out of gen_trace(), not sure which is best. This
way we'd have the fields printed after bpf_object__load() has updated
(if necessary) the autoload status for "obj", and
codegen_attach_detach() would then use the correct fields.

Quentin
