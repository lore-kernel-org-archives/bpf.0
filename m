Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411878;
	b=b7IKSFxugSahzErpGJDoyPLdR5uTrhKO1DPfALJQeMjHSFUkcg0xUM41RCDxZNOedpQy
	 s7Ex3AU3LoMG9QnfFVxOIoOP5F8X3TkuzwBaFmi7MGM2e/Sd7QIiVuN4fifojfMV8cDAq
	 9gl5l6/2QjNZ3iXkVd1ad0IfIgtkBj7nSN+AQZEbzLD2TopOgGfktDb2ULGX1YnEgsgSq
	 gYNOJeZ6Bly969jDIxuyunnilZDtofdPR4tyDnrNtIXiC/5id0vzSP3i/QNRgH7FJ92h5
	 NGpfZ77lfrS7jNYAxpr/znAw9XY1XDV621Yb7ljx26ooA7kOfjbI6WIUs/gtgGPV7MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Subject:From:To:Cc:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JW9NRbd1yObMC6jDLBg/nqkiPWQhNDyNhJfsXYnn4pU=;
	b=Tx+1tzOrTQcsTfZH3xLPS2Y7/7D4yy4tnh6oyDEPVTJbpzb+mI9VYrXXmA7RJQTi/Qc7
	 m5cSg+yPHoc3UIilmFiEDfRgU5HyqRbYHnOUH4QyB3+lzy63o+OvpfgqtPjlApl9YssJw
	 he4f3e518VQxql7dOv3yl1S0+n46lRGVmHiIBZFXxv0zYUZLFuEHzkMYj7cfEsCb1Tta9
	 0dkAeP0NZPUxlxztSJIQlrYxqGbLOX8xmj1i8DZytwQtcoHYwLM+/edAiZwvt6JaD2qxy
	 Qz4bb7Iz1JYuPKA4Ex8xKxbOyyJ5ew3Z78ReZqtiWkhY5ZV8wsbPWRZWm7vBTMs2OQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=izoDG3iG;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012A606A330
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4012A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=izoDG3iG
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso1314107a12.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794411878; x=1795016678; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JW9NRbd1yObMC6jDLBg/nqkiPWQhNDyNhJfsXYnn4pU=;
        b=izoDG3iGHFixQivI9rRvqjmYWQKXcAxXMKo5lrr/FgD+7cIps5M+XwXbaEzZjEaFbC
         Qfp4MbEFbtoS1YQadMXi4QUzIOvIVGNCdYmY4VmAGRwBGd4cGcXlRFF2NenrcmNSE/Qw
         MuO1bVS8bAiEcAEx6cX8s3pmw1aYOPUbPuMkZ+LJ1Y4GlbmcYI47m+aPsC5sLCMtP+ej
         7bydn2DN0wJ/ZD6al1gR5WNqbDXUEHJJkFixf8Bejm4/n/zJQUZFXfOSRTZ9IH5c48wJ
         Be1sAYk+qmq1AZ2aOK3f1madscB3bA0Zdv/1GEvxpp+51mI6nYZGAty1SMg3rHTi63eq
         /JFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411878; x=1795016678;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JW9NRbd1yObMC6jDLBg/nqkiPWQhNDyNhJfsXYnn4pU=;
        b=YGmRIYB1P7Q/DxF35QA3d+U0Q0auK9K9B3Wm+3D395uET/vKX6WGmGkdJ4Q5bydVuN
         XoZlx2wLgN/QZJDvJ8Yd4f8du+SB54IpLFn0Il1pDlqtSvY1u7+SmLMcPZQNgw6r69AF
         SZqggMqVfhJ0exswFgC1+HXIwOhkjKlqrjp7Ctqtgw2rDM8svlUWZnOY+2mlNaaNdDBR
         eI2BTw+0639RU1IIXN3ZP6hxpLetfWWhLmCUpjkNVLEVWm8L61sZKe+OkF7NfitpdS8r
         yJeeVBOk4otkJVmv0+QAGnrX8eBZZT88iB8pQraRAdHNeg/iUeUYa5lQFo7Rq5p64BmA
         k1pg==
X-Gm-Message-State: APuU4Z+LKRsfhqml2rrkrPWXC1mfVlrw4FckuxSFcr2bBLVjpTcEwpA7
	HpgSTlW4M+b8fme1h9fI4Jk7WkOvSxY7UL2exN5BJHykSTekAccTpiTk
X-Gm-Gg: AYBFou0oClPhHrTLMMJOzsOkARhtKGlIAvGSe9jmLlX+ThVAO2oUEec4ByxlTyrt7gs
	ZXizIGzBDfeU24a1T5ZQtIpsRD3U7BvcpVYLpWFoWB5aF2AX3D5DE7bI6Cugc5nKGqCkzypsS9n
	DxMoMOd7d9DXUJ1TMJi4pFI2z4BGMvKbdYpuM/psuv9bAcWQHx0odBlbsjJMTrm3/FYzuEk93li
	963J2Q5PBOx9W7R2w0ICcq64tMHVZP/itN+w5vA3cShtlasbADeWqvKuSIl84kw3rRRAs9dDAmE
	+Zri1NelfNm1DdpYnpo0l7AxL3hzxosDtOhSF2iGhrNVsIHQdhmZho6YAydQyHXlBG4DRuYUsF9
	eFIkC/dzGTOx4H74rLFRwYEY4Dsbh9gAmkEp0xj4p9VWzIgqYLuAhljQMuZAgUjjozuCuFvo0U8
	cMHm4clLGw3FRdA4msUscpQjDMKQGUmtyY354I4XKe2kDdE4EzBobl79RYkBDZ7sW4y8jKFn2Az
	BKrGnFpdvUsnsn05uTCv9BjnWRU7UpvCs3iw55ySrwEonps04+DAP0HoODcQz8GZuZbYjCYOqC6
	YogOXMWn/uU55nEUck+Lkm4Hl7PFVhyn8c+J8aQiE4ePjdrlbyY63q/6UfzrWenECyrB7M25b3v
	HcMEj41M2Qi7iPTLOZ9BJgx6jx/J4IDA0yapVlKD49g0vGgtcL/YEkTv/
X-Received: by 2002:a17:90b:4c82:b0:3ac:8446:c1a5 with SMTP id 98e67ed59e1d1-3b182f253e0mr2786337a91.48.1794411877445;
        Wed, 11 Nov 2026 07:44:37 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b18142fa70sm4663040a91.16.2026.11.11.07.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 07:44:36 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 15:44:36 +0000
Message-Id: <DMSHX7SU7M9U.2YBBRPD8DYGWN@gmail.com>
Subject: Re: [PATCH] mm/bpf: Add bpf_mem_cgroup_memory_events_local() kfunc
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hongfu Li" <hongfu.li@linux.dev>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, "JP Kobryn" <jp.kobryn@linux.dev>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>
Cc: <bpf@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, "Hongfu Li" <lihongfu@kylinos.cn>
In-Reply-To: <20261111-for-bpf_memctl-1111-v1-1-8b56784d9e5a@kylinos.cn>
References: <20261111-for-bpf_memctl-1111-v1-1-8b56784d9e5a@kylinos.cn>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 10, 2026 at 10:56 PM Hongfu Li <hongfu.li@linux.dev> wrote:
> Expose the local counters to BPF programs with a kfunc, so that a
> policy can attribute events to a specific cgroup instead of only
> seeing the aggregate of the subtree.

No. The prog can do it today without a new kfunc:

  memcg = bpf_get_mem_cgroup(css);
  if (!memcg)
          return 0;
  cnt = memcg->memory_events_local[MEMCG_OOM_KILL].counter;
  bpf_put_mem_cgroup(memcg);

memcg is a trusted pointer to a struct that is in BTF.

pw-bot: cr
