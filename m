Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62AA4E06E4;
	Fri, 16 Oct 2026 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164647; cv=none; b=mNxaadQZrGMvKVWFKwu4cwbNwI8qhI9evK1qtBS2E04xOPDQiQx8MpvJanDC3E/ZfPENJLLDVDDU/LpvOmJlDXX9jEtj1YCtBPTWdLuTRKAYvpd2wMISVV88Wne0FWvDwbMicukwyG6Llu5py4/qidP94YBQ/XDTDz1axM9yvL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164647; c=relaxed/simple;
	bh=GAQ6FCGhR6t9hjtL6x6Bg8PdWLpONS1NImJlys08QuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2mWz5qymOGeqxY8Q8TzNWj+WxTvmLXC3BlXc3XJrLE52M4Wj5YA4CZa8Znmb+E8lCMJ0v+hDvVWF1kkOpsHP+g5YhZ2cx1tZ7nnZsjQxcJiBEItCZbn/3WQfDApMqtGXn2Yp6GK5k09NBOgrbnVIOO9AMElKPf8x6dR3IAXdyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=RqPigvLz; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="RqPigvLz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XfKJ58eXOnKZEwOh226rdcvJbApA7j6ZlU6iAG3GTgw=; b=RqPigvLzuWwjtBDhfaD9aCs0Xw
	J2/ISFkHJyzvdLWL8uHXKhAqCMLkdtkUlitP6PizVVmF15vkReyY8oCL1zuotUK4Bl90B+cgQs3YB
	tT3kFjnjuE9Xl7V6ii+Et8kAzt9RBjWm70P2y6dF6srRyH4SnTAmBj3OViWcT5cKJwcw6kvv+5gwv
	lPier1a+Uo4Q83urfkJmNHHnaaoavnxS34DZe/ZSXSsB9TDLRaMlJdMjceTaMTfDx/fvfjoV0Z3Hz
	L/njx9hZi84M/4USAbgFNlO3y4hPXIBaTKmiIZ18IMbH1Zr6wHbcV+J93Mz9jx2dNurpPk/w1CnjP
	SyAe0rPQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHjtE-0005oE-2B;
	Fri, 16 Oct 2026 17:30:36 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHjtD-0008mO-0W;
	Fri, 16 Oct 2026 17:30:35 +0200
Message-ID: <334d2c0c-9ef9-4a20-91b0-73d1a3804f31@iogearbox.net>
Date: Fri, 16 Oct 2026 17:30:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/2] bpftool: Fail map dump for maps that
 can't be iterated
To: Maxim Skokov <skokovmaksimevg@gmail.com>, bpf@vger.kernel.org
Cc: qmo@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kuba@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, hi@tychen.cc
References: <20260928001513.7072-1-skokovmaksimevg@gmail.com>
 <20260928001513.7072-2-skokovmaksimevg@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20260928001513.7072-2-skokovmaksimevg@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28155/Fri Oct 16 08:24:17 2026)

On 9/28/26 2:15 AM, Maxim Skokov wrote:
> "bpftool map dump" walks the map with bpf_map_get_next_key() and treats
> ENOENT as the end of the map. Map types that can't be iterated fail that
> call on the very first key: local storage and ringbuf with ENOTSUPP,
> bloom filter and arena with EOPNOTSUPP, queue and stack with EINVAL.
> bpftool then ends the walk without a word and prints what it prints for
> an empty map, "[]" with BTF or "Found 0 elements" without, and only the
> exit status tells that the map was not read. On a socket storage map
> that holds storage for a socket:
> 
>    # bpftool map dump pinned /sys/fs/bpf/sk_storage
>    []
> 
> Ask for the first key before printing anything, and when that fails with
> anything but ENOENT, fail with the map type and the error instead of a
> dump:
> 
>    # bpftool map dump pinned /sys/fs/bpf/sk_storage
>    Error: can't dump sk_storage map: Unknown error 524
>    # bpftool -j map dump pinned /sys/fs/bpf/sk_storage
>    {"error":"can't dump sk_storage map: Unknown error 524"}
> 
> An error later in the walk is now reported too, as "bpftool map getnext"
> reports it, and the element count is printed only after a complete walk.
> 
> Assisted-by: LLM
> Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
> Acked-by: Quentin Monnet <qmo@kernel.org>

Sorry for the delay, could you fold this in to make the 524 a bit more user
friendly? Maybe its also worth to check other areas in bpftool for similar
case and then do this as a small helper?

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index b7f62fcbb6fc..b656f176bcaf 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -858,16 +858,21 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
  
         /* Fail early to avoid an empty dump if map type cannot be iterated */
         if (bpf_map_get_next_key(fd, NULL, key) && errno != ENOENT) {
-               const char *map_type_str;
+               const char *map_type_str, *err_str;
                 int saved_errno = errno;
  
+               /* ENOTSUPP is kernel internal, strerror() doesn't know it */
+               if (saved_errno == 524 /* ENOTSUPP */)
+                       err_str = "Operation not supported";
+               else
+                       err_str = strerror(saved_errno);
+
                 map_type_str = libbpf_bpf_map_type_str(info->type);
                 if (map_type_str)
-                       p_err("can't dump %s map: %s", map_type_str,
-                             strerror(saved_errno));
+                       p_err("can't dump %s map: %s", map_type_str, err_str);
                 else
                         p_err("can't dump map of type %u: %s", info->type,
-                             strerror(saved_errno));
+                             err_str);
                 err = -1;
                 goto exit_free;
         }


