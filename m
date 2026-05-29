Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E353438A4;
	Fri, 29 May 2026 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062572; cv=none; b=hNqMl35+UGrCzReKzPbLoLRc0qS4sfOwfNJbiO7SLvg7V9jayxx2ebY3nSQNuJnWZ5grSRfEMXilJIFtvNpYG0m2ZSLuAKYHcM6BxLJsfBNTP5aS0jTv9d9REk8FmOpaMbXN5v/ApEIDg/PdchfuYaanfk+Ep4A/SEFdbrC9FBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062572; c=relaxed/simple;
	bh=hoct2HFDnKC5DFYG81ttwcBpclC7KqAPBuewW2arKgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sh5jS+68cEALidFZ5sHSXTLK/8JyPWjy5zER1thskjjBtYeAxKC39zTiBRP84v6NDKZgeym3icQs+6cKK3+JJtfjo74AlSJDzc5U0eH0ZJytdRZ+pvFo6dcecU9IZWpqdKt3VUKx+/o5o/iRY1aCJdL9RQvI9Qnx39qJ/c3d5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=U4gr08R0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="U4gr08R0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZiCGWHoXJTR9rObZHum3TfWvVxF5kf2yiGZZntOQnJw=; b=U4gr08R0nZdfzaHsiNhe1a2tdp
	4Y/wlDzcruRLyoMZoc75eVEeybXMoGyJsYsoLYHoDO9qUNoa6/UpM0UX3T2OeWHL1zluRwd1Cqmsx
	j+Qyw9pwGyzUNUU7Fd49PXxLoq0GlgscBv8RKZxKnabUJ7HP5mQZE1Gt5gaU796pU5EBnAXzxis/c
	I1lrEiOkxqCWeMPUPL4fLAJ77vgEWfO+PwOsHGyszifPX15CfLj+qZ8uyH178Xmqm3I39O7VRYOG4
	jKIYw+ddibEaIKcqzxkMhZb6f8v1xMQ5v+Wt7rfXmvabIvNPXF2+2t0tgHe8CNsY7CYecd6qT17j3
	HS0xytWg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wSxaa-000PFE-1U;
	Fri, 29 May 2026 15:49:28 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wSxaa-000GjK-0o;
	Fri, 29 May 2026 15:49:28 +0200
Message-ID: <030307d2-f065-4434-b746-4ef5349f6190@iogearbox.net>
Date: Fri, 29 May 2026 15:49:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] libbpf: Skip hash computation when loader
 generation failed
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260529094119.307264-2-daniel@iogearbox.net>
 <20260529102131.B66FC1F00898@smtp.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260529102131.B66FC1F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28015/Fri May 29 08:24:51 2026)

On 5/29/26 12:21 PM, sashiko-bot@kernel.org wrote:
[...]
> [Severity: Critical]
> This isn't a regression introduced by this patch, but while reviewing this
> file I noticed a pre-existing issue with how generation errors are handled in
> bpf_gen__prog_load() and info_blob_bswap().
> 
> If realloc_data_buf() fails inside add_data(), it frees gen->data_start,
> sets it to NULL, sets gen->error, and add_data() returns 0.
> 
> However, bpf_gen__prog_load() doesn't check gen->error before swapping
> endianness:
> 
> tools/lib/bpf/gen_loader.c:bpf_gen__prog_load() {
>      ...
>      insns_off = add_data(gen, insns, insn_cnt * sizeof(struct bpf_insn));
>      ...
>      if (gen->swapped_endian) {
>          struct bpf_insn *insn = gen->data_start + insns_off;
>          int i;
> 
>          for (i = 0; i < insn_cnt; i++, insn++)
>              bpf_insn_bswap(insn);
>      }
>      ...
> }
> 
> If add_data() failed, this evaluates to insn = NULL + 0. Can this cause a
> NULL pointer dereference when accessing insn inside bpf_insn_bswap()?
> 
> Furthermore, if gen->error was previously set (e.g., from a failed
> realloc_insn_buf) while gen->data_start is non-NULL, add_data() still returns
> 0.
> 
> Since the loop evaluates insn = gen->data_start + 0, can this overwrite the
> beginning of gen->data_start and write past the end of the buffer if it is
> smaller than insn_cnt * sizeof(struct bpf_insn)?
> 
> Could we add a check for gen->error before proceeding with the endianness
> swapping?
Yeap, for the endianess we would need something like the below ... will cook
a patch for it to address :

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 19f9c05f8388..501508e5affa 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1071,7 +1071,7 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
                  prog_idx, prog_type, insns_off, insn_cnt, license_off);
  
         /* convert blob insns to target endianness */
-       if (gen->swapped_endian) {
+       if (gen->swapped_endian && !gen->error) {
                 struct bpf_insn *insn = gen->data_start + insns_off;
                 int i;
  
@@ -1109,7 +1109,7 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
                  sizeof(struct bpf_core_relo));
  
         /* convert all info blobs to target endianness */
-       if (gen->swapped_endian)
+       if (gen->swapped_endian && !gen->error)
                 info_blob_bswap(gen, func_info, line_info, core_relos, load_attr);
  
         libbpf_strlcpy(attr.prog_name, prog_name, sizeof(attr.prog_name));

