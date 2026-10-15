Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA75A3F4DDB
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090571; cv=none; b=TecarjmCAZvvcDweirx+eP1KLCQJWX8cE7T1BQ56OGJkliMN4QER/PVOSgtVpRBmDFu9B4qKIiQguHF8tjlqXkPhaVqHrXgDsHrFGOsO61McmdfC0skUH7XhMKNvHL3J3mGALgFLce1H4PuggkKMZKIa9Zve+aKFChpMBaFwX0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090571; c=relaxed/simple;
	bh=HAsbaut+aS/CdCQQDFYbxBMxo6DuX3NZs2xJh7w6hFw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=l/cybX0laa25bG+ees4M/ZlAuqhPFzUdhw+W+/AONAHW1LFCKye1u0GZx+WP5Jmej8vVC/c4nLC3GyrO6coq3v7cq0KQUb99EERiEg5XRaKFzxx5cseHxfuVxXf3Iv6CR4CvHMzHuecSjIdTSsWUxYvbqaEssTJCj31QofhmxKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huV9OUXW; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huV9OUXW"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-892734ce7e6so1073979b3a.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792090565; x=1792695365; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q7e4SrovosS8zPVDVatQWS9OOElh4/5VaE9Q0ngTkFI=;
        b=huV9OUXWs/wSds8K5G14Ig2wD1TPKYnJPvO9A71z4TOy3ME/rTGN72B6LNmPvgqNxe
         Apn2YelHNLA/3FoL/fjDI1eW6PkSYRDWaG9KJxBOS9sqD8IrkmHj9zZ3aP4mWMM6TvR1
         JquuBTeR+v02E4bRv+pGbfGAU0kRX1y83K/XFH9mlZRnwHd/LIGbpwXDtFH6gbUtDBTg
         XYtdM6W/58BEmBMcw7VSW1aJoKGz1GlL9emW808AKJk6TuFSTWEZHSZtikx+iCowDwlo
         W0orKDBppBT3u8MB4yXXUKMs/oL8K0LRKo3f3haq11Rr/RghIIdKb7iDj49BKhfEvInl
         CqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792090565; x=1792695365;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q7e4SrovosS8zPVDVatQWS9OOElh4/5VaE9Q0ngTkFI=;
        b=UbwYAII4rLlm5TWFAoh9PD53V+DbXJRH/CB1fdFYbHGJ1NCLb8gXki4qQrYcMYU39P
         OqScjKnhtqVq5XsnBOXBzW100EiHoXcrLhccJN38aYZED8zpb28qURmGq1r7w2WgEQoM
         F9KC8/RXkn5In4lVnnZSWtBfV3sUJLX7s2pEkHqfBI7jhzSA8BTFnrL0QE1UjV+K6ec4
         48ungj8d6mPmq0KFwdY+Xitu1tzFYC32HRY3ZonayQ12GQxggIp46pc90WUTZFmChFvO
         EtnOz20yNLe7AkPaEYMCGAu3Q3V8rMF5YVXghff8sgUxyLvAGna5YVkv2w0Ur78vMlJo
         EJ/w==
X-Forwarded-Encrypted: i=1; AKwUvBw54MV7A0dUSqWc+S10l65yyYQzAeRIEMuORVDYDZLD1VgPTJKPaHR/lHCv9sgkofUqeuI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJA+/tyacMoNJh8PXE9NmJ0W7VxbNmA+yeLJYhcv41UCSEd4YeS
	2P8d+/u+ek+RzLLUvOZQ+OhUmxZaSUmRmy+Of8hPK4mRe7uSW05job+/
X-Gm-Gg: AYBFou2w9Vw8K/YpCarZ/H5Rr2A1cT2Jb+aJ8mmXklttcVzK6284StnlvAeMpkVTlkW
	CMAmapxtaSVQsiwre/2+36V5wkeJUvBpZkGFZplk5ALNzxOpdh/yIqmNiJ96XtzyMdWZWYC39LB
	9VIVca16dKy62jqrsGWVzlMv4WeWWd3npy6I1UCMJSKvj5Zpwxk+JOnQ59O6ig7OANWR6TbPI2Q
	ee47TmVGWxdUD2wVBPOibRqU2zY/hMITF8Jq+IiHFvps3voVMFersncxaDjXIEQiLb1yGfheBWo
	66bz9pQknF7FwtSJKg4r8qU+qQTncgvqdVycAFBgYiHawPQgpUSdRc8aopnyTkonWwvlkX/kcgz
	Vt0nl0t6Phxo0dIjK5QBglHfpex63SUa/FEhsVVKxp2PrzfDT4Q9kvXRlH7N7TYyGbZcdo1OP7M
	uK5W0A7RMfHmtX2Daoizi0x9emIkKownvgb6aQPgd0Pos1ZghZCPM9Eeg6hFjapJKqTNTwMaxJP
	C8pzW+ugRt3WpxSa69f5wfQBjlsx0D0ytWPb5UslsetKb9SpsTScwvrrAH8jLln2xGhjX31sO20
	gP4=
X-Received: by 2002:a05:6a00:1889:b0:89e:cfbb:e8a2 with SMTP id d2e1a72fcca58-89ecfbbea2emr1701444b3a.4.1792090564788;
        Thu, 15 Oct 2026 11:56:04 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5820b344sm57450b3a.53.2026.10.15.11.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 11:56:04 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 18:56:03 +0000
Message-Id: <DM5N33KZWMCJ.AE5D51WCR236@gmail.com>
Cc: <memxor@gmail.com>, <yonghong.song@linux.dev>, <puranjay@kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 02/18] bpf, x86: Omit the displacement byte for
 zero offsets
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>
In-Reply-To: <20261013171230.523677-3-daniel@iogearbox.net>
References: <20261013171230.523677-1-daniel@iogearbox.net> <20261013171230.523677-3-daniel@iogearbox.net>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Oct 13, 2026 at 07:12 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> @@ -1120,18 +1120,26 @@ static void emit_movsx_reg(u8 **pprog, int num_bits, bool is64, u32 dst_reg,
>  static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int off)
>  {
>  	u8 *prog = *pprog;
>
[...]
> +	if (!off && !base_needs_disp(ptr_reg)) {
> +		/* No displacement */
> +		EMIT1(add_2reg(0x00, ptr_reg, val_reg));

progs/verifier_jit_convergence.c depends on the size of these insns.
It's the reproducer for
commit c8831bdbfbab ("bpf, x64: Fix a jit convergence issue").
The code between 'if r1 == 0x0 goto l0' and l0 is 125 bytes when
the last 'goto l9' is 2 bytes and 128 when it's 5.
That's the je <-> jmp cycle.
There are three zero offset loads and stores in there,
so it's 122/125 after this patch.
'r2 += 0x1' and 'r3 &= 0x1' in patch 8 make it 120/123.
je fits into imm8 either way.
The test still passes, but it doesn't test anything.
Pls add few insns to the test to get the distance back.
