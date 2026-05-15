Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B93EEAE9
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869707; cv=none; b=pPiaaGWG9hiMcwa7NvkWHw6xTqYOuAMT+lLMA1J3xHpiUC2KTckwAXkqwhj94cHl0mlaFQfYcnopg9tfQKLMJaI6x+ZuOdpUCVxvp0ud+Z0x+rZUsD75bECxLDLEPH8HEcmGYONv7XiQq/Pv8qOIhIf7/IoI1E5IIJdoZTtG0t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869707; c=relaxed/simple;
	bh=9CqivdOtEu4A2vc+2oIRyhT4hwgAQpw6jlhg8/uvt1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gu+Q8wFBA7RibU1PBhzSa6i3v+x++euAQWTgtXebUPVuAmu4qQ4ZRKj0Fr5a1AP5QNWIyaDJKjd8d4fD/hmugH7BEkEESgPdarx76HEom+Wo3uk/peoTywyZKgKV9MdNYVhQ0sW71OKKPJ52+ZMzWmqsgTumH3L64aeKTHmi2Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iEjAhTf7; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iEjAhTf7"
Message-ID: <c1719854-d732-4ea6-9da9-26aaf21e85ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778869693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7KQbURJVJFNJLLR2ilh4aULfEJVXnigcpe56pKwWMQ=;
	b=iEjAhTf7jfLn11y+s4E+311K2xX2Y2pSgQKdIwVUuTEmnoSrl09dUrFH8XMQVcTB/Zv34F
	SdKmNxpx1Olxc3hOsu8L9NLs2FezE3tdolJVc9OI7AiKH5zZEmdErBYtVRfmA5UX6gzSzt
	O8tU9+u5GnP4Tk7Alht3HatqCzH9nW0=
Date: Fri, 15 May 2026 11:27:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: fix btf_types_are_same for cross-BTF type comparison
To: chenyuan_fl@163.com, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuan Chen <chenyuan@kylinos.cn>
References: <20260407080900.551797-1-chenyuan_fl@163.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260407080900.551797-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/7/26 1:09 AM, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> When comparing types from different BTF objects (e.g., module BTF vs
> vmlinux BTF), the original btf_types_are_same() returns false because:
>   - Type IDs are local to each BTF
>   - Pointer comparison of btf_type_by_id results always fails
> 
> This prevents kfuncs with KF_IMPLICIT_ARGS flag from modules (like
> bpf_kfunc_multi_st_ops_test_1_assoc) from properly recognizing implicit
> arguments such as 'struct bpf_prog_aux *', causing the verifier to not
> inject the aux pointer value during fixup.

Hi Yuan,

Could you please provide an example of what is failing? For example, a
selftest, verifier log, or at least the (btf, type_id) pair?

I am guessing the root cause might be that the distill_base deletes the
types used by implicit args (such as bpf_prog_aux), causing .BTF.base to
be incomplete, and module BTF duplicating kernel types. But I'm speculating
here due to lack of an example.

Module BTF is supposed to reference base BTF types through the
distilled base. If struct bpf_prog_aux ends up as a separate
module-local type instead of resolving to the vmlinux BTF type, we
should fix the distill_base/relocation handling so the module BTF
points at the canonical vmlinux type ID. Then the existing strict
comparison will work unchanged.

To Alan's point, changing btf_types_are_same() to compare only kind,
size and name makes it too permissive. Two different structs can have
the same name and size, but different members or semantics.

I think we should identify the root cause and fix it.
This patch is a no go IMO.

Thanks.


> 
> Fix by comparing actual type content (kind, size, name) when BTFs are
> different instead of comparing pointers.
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  kernel/bpf/btf.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d78581207..daad28ae32e5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7432,15 +7432,39 @@ int btf_struct_access(struct bpf_verifier_log *log,
>   * the same. Trivial ID check is not enough due to module BTFs, because we can
>   * end up with two different module BTFs, but IDs point to the common type in
>   * vmlinux BTF.
> + *
> + * When comparing types across different BTF objects (e.g., module BTF vs
> + * vmlinux BTF), we need to compare the actual type content (name, kind, size)
> + * since type IDs may differ between BTF objects even for the same type.
>   */
>  bool btf_types_are_same(const struct btf *btf1, u32 id1,
>  			const struct btf *btf2, u32 id2)
>  {
> -	if (id1 != id2)
> -		return false;
> +	const struct btf_type *t1, *t2;
> +
> +	/* If same BTF object, ID comparison is sufficient */
>  	if (btf1 == btf2)
> -		return true;
> -	return btf_type_by_id(btf1, id1) == btf_type_by_id(btf2, id2);
> +		return id1 == id2;
> +
> +	/* Different BTF objects - compare actual type content.
> +	 * Type IDs may differ between module BTF and vmlinux BTF,
> +	 * so we need to check if the types are semantically identical.
> +	 */
> +	t1 = btf_type_by_id(btf1, id1);
> +	t2 = btf_type_by_id(btf2, id2);
> +	if (!t1 || !t2)
> +		return false;
> +
> +	/* Must be same kind and have same name */
> +	if (BTF_INFO_KIND(t1->info) != BTF_INFO_KIND(t2->info))
> +		return false;
> +	if (t1->size != t2->size)
> +		return false;
> +	if (strcmp(__btf_name_by_offset(btf1, t1->name_off),
> +		   __btf_name_by_offset(btf2, t2->name_off)) != 0)
> +		return false;
> +
> +	return true;
>  }
>  
>  bool btf_struct_ids_match(struct bpf_verifier_log *log,

