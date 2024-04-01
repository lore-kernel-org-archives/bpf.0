Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D048853E0C
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712001040; cv=none; b=dmF5Qq97T7FFy500hxaFxAQOFolPQ70b/0JwV0kUogCnMf5XyyqouYahhyHS5o8nMyXsx8gmRGGopcWqO18AkeuIISJLdS92NQA73XYuD2wnAV/ZPA0GcF9CDrIwKfTL4yzeWKTDiG8HAoEDv6Y2xCqTO3VL5GXc8KkLXD1941s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712001040; c=relaxed/simple;
	bh=eByiN90C0tzLm/B0DWkGFX79TdN28GrZdBgxIgeQ5UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qo8yQQ0rUaHF7Ii6qRnM3IK19da0j34zLLi9li0Qz5Vw1zRXRKgKI+Dgac6RuiS6mxye0kxuHApR8eOvKRtB5gcgaYNrnbzQfkcXyfatuIY3G6ioqkq6t0xu2cFZMEtvOgrlXQupDWCzggUHdBehRqArhdgeHH/KD9cZ5w37ZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StpxS3ey; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StpxS3ey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27AEC433F1;
	Mon,  1 Apr 2024 19:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712001039;
	bh=eByiN90C0tzLm/B0DWkGFX79TdN28GrZdBgxIgeQ5UE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=StpxS3eym56PNjMFXPwlh6jy3IQhmMU+n0TYAKRvjISHXFvOMY4Zfs46K41eMvudy
	 jEdCMkpF8JzH+SauIy99bTzNl0BlBkWhEf0MB7aAn2zqj+Upj3CBtG6T8y6vN52LKw
	 bL5j7QemPvXI9BugHk4UB8YkQCaJjwCUe6r5O0Sbmlp1nCPFnVXSe5Gr3jZoQfyHus
	 v3jOY/+53qIDwm3r/8dzllvZrlAy49A8fYTkdmLTlTn1zUy7KhR29X5ffUsSUsQlU9
	 YvWO/NfcUdbehibAdg2+kEfjPaUJ2wzsSpu9zDdp1mR3uMocjpHGpYbycfEGBrsQt+
	 VqasSDSSm14fg==
Message-ID: <2dde160c-930c-452e-9107-c9e34f6ebdff@kernel.org>
Date: Mon, 1 Apr 2024 20:50:35 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next] bpftool: use __typeof__() instead of typeof() in
 BPF skeleton
To: Kui-Feng Lee <sinquersw@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20240401170713.2081368-1-andrii@kernel.org>
 <b5af75b1-892d-4640-9222-7fe8006d1da9@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <b5af75b1-892d-4640-9222-7fe8006d1da9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/04/2024 18:59, Kui-Feng Lee wrote:
> 
> 
> On 4/1/24 10:07, Andrii Nakryiko wrote:
>> When generated BPF skeleton header is included in C++ code base, some
>> compiler setups will emit warning about using language extensions due to
>> typeof() usage, resulting in something like:
>>
>>    error: extension used [-Werror,-Wlanguage-extension-token]
>>    obj->struct_ops.empty_tcp_ca = (typeof(obj->struct_ops.empty_tcp_ca))
>>                                    ^
>>
>> It looks like __typeof__() is a preferred way to do typeof() with better
>> C++ compatibility behavior, so switch to that. With __typeof__() we get
>> no such warning.
>>
>> Fixes: c2a0257c1edf ("bpftool: Cast pointers for shadow types
>> explicitly.")
>> Fixes: 00389c58ffe9 ("bpftool: Add support for subskeletons")
>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> ---
>>   tools/bpf/bpftool/gen.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>> index 786268f1a483..b3979ddc0189 100644
>> --- a/tools/bpf/bpftool/gen.c
>> +++ b/tools/bpf/bpftool/gen.c
>> @@ -386,7 +386,7 @@ static int codegen_subskel_datasecs(struct
>> bpf_object *obj, const char *obj_name
>>                */
>>               needs_typeof = btf_is_array(var) ||
>> btf_is_ptr_to_func_proto(btf, var);
>>               if (needs_typeof)
>> -                printf("typeof(");
>> +                printf("__typeof__(");
>>                 err = btf_dump__emit_type_decl(d, var_type_id, &opts);
>>               if (err)
>> @@ -1131,7 +1131,7 @@ static void gen_st_ops_shadow_init(struct btf
>> *btf, struct bpf_object *obj)
>>               continue;
>>           codegen("\
>>               \n\
>> -                obj->struct_ops.%1$s = (typeof(obj->struct_ops.%1$s))\n\
>> +                obj->struct_ops.%1$s = (__typeof__(obj->struct_ops.
>> %1$s))\n\
>>                       bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
>>               \n\
>>               ", ident);
> 
> 
> LGTM!
> 
> Acked-by: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Thanks!
> 

Acked-by: Quentin Monnet <qmo@kernel.org>
