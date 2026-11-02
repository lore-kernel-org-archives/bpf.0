Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633301;
	b=jg4u3CXS9VyHhRnNs7MyrFX/Bk1idHP5i7FqgjNkPcRZb07i0MxR5KRM94JFAzW63vTz
	 V9f2Fll8FWL016MYPDUlCDes5ekqbKSJ2O4BmVrDp/DTH6eGqLeorMFWnd6vXM4psFiMF
	 e8r8Ylyf6ljrPxiaYYVuYWQgyEc7SSXtQDhGc4xqKqeC/8MRAsEnj1Lr8+Rw6ocPndhGo
	 vCA/ZCK/8AxHK1AkKP/VnhIrc6wlzWtuFoRqxnqL006mXB2zzJkg0H+/hOg9vTF4xp3Mz
	 Dq9bi3YRufLUi9IFymMIG++G2m8xRnqYiCN5+J0qorb5ZvGieRN2tm5C4SHTYWZ471Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633301;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=QxPeDUrP8twWSpeKToKl8Bg8IK9ZxQf0gM28I1RQIK4=;
	b=L3J45BqiAuWfT+ixkSiSXbndlOpjrgios0lmT/xomC/ohaJsLQ74E0yjNUM5S8O//cmw
	 XJSX7Ur/gdYQj3oFmrI8jT4gQgDbfd9ilY3JFPXW+UoGbN2Fq6XXofUQvUl2ZfJ00QPf2
	 DjXU12Eb14cjlKVVkpReOiZTpwbbmvbgIfNo1mgmuWJVN305JfVEuEqkd2Y+6V9utRTz/
	 pmDGpfh7FtTuuEASnE7t3DMLCmb3WK1xpgB1DZiAwVcm8F4ey0kjp7pXiZYo7DlF0RXmh
	 VKRoFfWSiq89gwuUgK7QClTFsahR+DuW4l0jOufe6Q9ZV4j1VrdpBA0XGnvbAEgPoAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Naxxyoi3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0A8608508C;
	Mon,  2 Nov 2026 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Naxxyoi3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A181F00A17;
	Mon,  2 Nov 2026 15:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633301;
	bh=QxPeDUrP8twWSpeKToKl8Bg8IK9ZxQf0gM28I1RQIK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Naxxyoi3XiL4dGgz9c28bngMe7B7Vnw0UmEiKK0JYiIwa3Q35ApKb5dcOUC1lJBX2
	 a5bIUynDN4RBFOi2CPahGwSs8+NbLxqJ4AtjkXwwS0pj/lbLDJi7o7UccvsH+ZhI1K
	 Ankq34h0dz5BCJz3RhePJy7ZPpCdmZbxrGz/MzWvI5+ce1xli2NymlgP4654a9tPP1
	 SrzpCDtWMXOY1Z+xy6vDn4U7yQWRUCy2a9wTsf9J6Yj/uyOuOnwHaBFNBkPmO97X3i
	 EViV++7yeQWoDErazho7NqNwaY7YvO2doeMqosnKuFpsrdAinXS4IQchbPfZJ5ruUH
	 wV+OINbSqaHVw==
Message-ID: <51a8ab27-3c2a-41aa-90d7-fb9f321bea4f@kernel.org>
Date: Mon, 2 Nov 2026 16:28:18 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] bpftool: Preserve unsigned enum values in
 data dumps
To: Hungyu Lin <dennylin0707@gmail.com>, ast@kernel.org, bpf@vger.kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, yonghong.song@linux.dev,
 eddyz87@gmail.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261101103221.51534-1-dennylin0707@gmail.com>
 <20261101103221.51534-3-dennylin0707@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261101103221.51534-3-dennylin0707@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/11/2026 11:32, Hungyu Lin wrote:
> btf_dumper_enum() loads ordinary enum data as signed and uses signed
> numeric output. Unsigned values with the high bit set can therefore be
> printed as negative numbers. Narrow unsigned values also fail to match
> their enumerators: an eight-bit 0xff is loaded as -1, while its named
> value is stored as 255.
> 
> btf_dumper_enum64() likewise uses signed numeric output for unmatched
> values. For example, 0x8000000000000001 is printed as
> -9223372036854775807 instead of 9223372036854775809.
> 
> Load the data according to the enum's signedness, use btf_enum_value()
> for name matching, and select the numeric writer according to kflag.
> 
> Retain the original signed-width comparison and give it priority over
> new matches. This preserves names from older BTF without signedness,
> including eight-byte ordinary enums, and keeps the selected name when
> multiple enumerators could match. Remember the first normalized match
> while looking for an original match so only one scan is needed.
> 
> For an eight-byte BTF_KIND_ENUM with kflag clear, a negative stored
> enumerator can therefore match both its sign- and zero-extended values.
> The record cannot distinguish legacy signed metadata from unsigned
> metadata with the same bits.
> 
> Unmatched values are printed as unsigned when kflag is clear. This
> includes BTF read back from kernels without enum64 support, where libbpf
> clears kflag before loading. The original signedness cannot be recovered
> from that flag.
> 
> Fixes: ca7e6e45d108 ("bpftool: Print the enum's name instead of value")
> Fixes: 58a53978fdf6 ("bpftool: Add btf enum64 support")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  tools/bpf/bpftool/btf_dumper.c | 42 +++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> index 3267163119dc..792e210cb503 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -148,37 +148,50 @@ static int btf_dumper_enum(const struct btf_dumper *d,
>  			    const struct btf_type *t,
>  			    const void *data)
>  {
> -	const struct btf_enum *enums = btf_enum(t);
> -	__s64 value;
> +	const struct btf_enum *enums = btf_enum(t), *match = NULL;
> +	bool is_signed = btf_kflag(t);
> +	__s64 value, legacy_value;
>  	__u32 i;
>  
>  	switch (t->size) {
>  	case 8:
> -		value = *(__s64 *)data;
> +		legacy_value = *(__s64 *)data;
> +		value = legacy_value;


Not sure that's worth a respin, but "legacy_value" will lose its meaning
in time, maybe name it "signed_value" instead?

Looks good to me otherwise:

Acked-by: Quentin Monnet <qmo@kernel.org>

