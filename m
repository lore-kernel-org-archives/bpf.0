Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1B035A933
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786750026; cv=none; b=RtQY2JBYGUu7+O6vCtrHX0qoDcFyaE5IgZ3iOaaVxu6//zc2mE4Cc+rJ1/TL6NM4KNN8L3NcJcD2s6UJ5w+K1S/ecfOtrjmXrZhiC0H0oOB3rhoofAr2VyRr0tiD1w0AMlHC+Lw7qT1c0tXVj6zvF3ssGQg4W3qwNFOxRjkGkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786750026; c=relaxed/simple;
	bh=qPhiBz3u8RTcIbLhG/5zL3xlY/oKASN/eSN7X3P0Nzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnblBF0nZg5YhctOh/gr8toTazFwvm6yxMcAfncpG8hnke7m34jqfaPwQkvRySJ9Omw0h+FFPf9zsYTiXcErUeI26KstYxxHkH2pPCvv6wqcvpA0HR7p3QUmqFf0hsy5Szjibd3wCkA2cm3lVfqiv5xTHXKma61Gbt1nR/smdtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=RF8BxrUz; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="RF8BxrUz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2xntvsBU9+cWBOGBDBvrfho9zbdxgXqHjIlhMarSiaE=; b=RF8BxrUzfDx7zhm91SAVvXLFKw
	llhe27xBdX49qwnOJu1BW9vwI7+ajueBVjs0d6ZZ08VHWYcNahE5sytmle6zr1+ABE44+Y9eRHn4Y
	z2k7VlgtYKI5ZmgVhZ0+fIde7+pQTmoeMI9JH4cz1Vz35khJU5uOJFqmdIUMOEicj5NXZCEFmy3OE
	/9T0PCIMV7z073/PK0hky+Wqv4gc+ISg7UUgeCxBu/0gzUZxhj9O26zY7KUmzO6+XwGd7SFwzA1I5
	VlVPq8Qr4qFNBPTmujWZiXOcdTPxrV2BQqZOT+QEXCcYEIAad7SC367/8Ps27TzPEcu8n84kgER8Z
	XuMihQsQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wv1If-0007Mi-2t;
	Sat, 15 Aug 2026 01:26:57 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wv1Ha-000Obx-01;
	Sat, 15 Aug 2026 01:26:57 +0200
Message-ID: <3338e184-1aa2-48b0-8840-27076cba8ecd@iogearbox.net>
Date: Sat, 15 Aug 2026 01:26:56 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Reject a store through a fault prone
 pointer
To: bot+bpf-ci@kernel.org, eddyz87@gmail.com
Cc: memxor@gmail.com, bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260814215301.709827-3-daniel@iogearbox.net>
 <5b81c3f28a2ca32623bdc5e1e2ca55d797d37739033a0ef1338f1c93bd6911bc@mail.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <5b81c3f28a2ca32623bdc5e1e2ca55d797d37739033a0ef1338f1c93bd6911bc@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28092/Fri Aug 14 08:27:02 2026)

On 8/15/26 12:40 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 814096ed835d..cbbb0c82d22c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5788,7 +5788,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>>   		return -EACCES;
>>   	}
>>
>> -	if (atype != BPF_READ && (type_flag(reg->type) & PTR_UNTRUSTED)) {
>> +	if (atype != BPF_READ && bpf_may_fault_on_deref(reg->type)) {
>>   		verbose(env, "only read is supported\n");
>>   		return -EACCES;
>>   	}
> 
> Does this change also reject HID-BPF writes to struct hid_device fields?
> 
> The HID struct_ops hid_bpf_ops_btf_struct_access() whitelists writes to
> hid_device::name, ::uniq, and ::phys via WRITE_RANGE entries in
> drivers/hid/bpf/hid_bpf_struct_ops.c. A HID program receives a
> 'struct hid_bpf_ctx *' argument that is PTR_TO_BTF_ID | PTR_TRUSTED, but
> walking hctx->hid produces a bare PTR_TO_BTF_ID because
> struct hid_bpf_ctx appears in no BTF_TYPE_SAFE_TRUSTED list in
> check_ptr_to_btf_access().
Hm, that doesn't seem right.. potentially sth like:

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 702c22fae136..56c53aca4511 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -62,6 +62,10 @@ struct hid_bpf_offset_write_range {
         u32 end;
  };
  
+struct hid_bpf_ctx__safe_trusted {
+       struct hid_device *hid;
+};
+
  static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
                                            const struct bpf_reg_state *reg,
                                            int off, int size)
@@ -86,6 +90,8 @@ static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
         const char *cur = NULL;
         int i;
  
+       BTF_TYPE_EMIT(struct hid_bpf_ctx__safe_trusted);
+
         t = btf_type_by_id(reg->btf, reg->btf_id);
  
         for (i = 0; i < ARRAY_SIZE(write_ranges); i++) {

