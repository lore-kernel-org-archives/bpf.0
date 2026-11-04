Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759310;
	b=hrvnsLs5GAOJMj9zoI8Pw3biMdj+r0c4nczckEiund/JDkR+5doghFTKjExsZix3ScaH
	 McvMfWmRU5sunKdO+2tyavVrJENN7wjz/hZmkdHpcS6/E8RmyA7SX8k1WYe4yrUMpc2Ba
	 +fzbSPGSMQnHidVmL3i5d5CyAc1Rr+UpXknq64gDHFkD8wD/8iZ6t2BAOTynzDAakmg7E
	 zbgh2Iua5U63VGiRphEQRabLz1eVfV1C7JORP1eAdgpyWB/queA39HwgcfjGcnXbZsbRI
	 gHhaIzJlH5bebmt0x9k0k4K7An/9DjzyVXTG7Rhxd9GqfUvw6fLbmw5qzI/XrjTJExQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=pllLqFu+4Zv9EXcFMsURZ0heoaKm7NbP0cOiSWm0lgI=;
	b=FtwY143xL/TWE0zsrB0DcJ48lbSixpw3r/OHTBpeGzPgZWAtobweZkiHwtIpXMBbbfeJ
	 R6h4yEMJsp8xIpb4+cV5MxZ82Um5MmqPhW11iOiiKWGNVNg+K5iRI/Ziew8lbW0KyNnuF
	 8gHC0FDpJpX7tidmRpVejRrfPkJKEQ4idzuuzhL35UvugPL+iDxKSdp9FHIHxcTdj8bb6
	 K2vloz8zPm+r7Or97Y1gbs0wXjnmATfOuTe/qJcFq86aZlWmEHy+TW4elEj1mbwGuV1b9
	 9QIhjb0lwJs36KmUSevn6qSh7dq61zHcxYaNyCWrwrmYWS1+sRtfvXbZbTXzvW8Cv9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jTMmHOX7;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB902606A32C
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB902606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jTMmHOX7
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso188691a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 18:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793759309; x=1794364109; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pllLqFu+4Zv9EXcFMsURZ0heoaKm7NbP0cOiSWm0lgI=;
        b=jTMmHOX7ft2XTe8GK8vwACY1tXp8EJI5KE+WW3x4XlyGAe3Dp9LXJ5hhCmY18wfRHW
         ThaMyY1DM9uY1WCIDnqpwj0XiENItgSnkLGEpZDqH7sVW9Rk/4vxgpPhqVo8FFZoWMqq
         BAMb6ubQ4R4P86LFCOuW1dV5KHfOp9yRVmpVJuDM9WRVpxLINhylfgx5hzvt25UG2GdB
         t6bzF2/jFonAiXnp5JZ7P8ikEF0JfKKfRM55jw7QkOj2ek+7HpVc9YimTZieFAsJs7p5
         pNje15tc4n1ZKiWAk6pQr+r3VxHV2obAK0uAA7LLpp/pxTi5kWYFRLGpQjQ3AAJwi8/r
         erBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793759309; x=1794364109;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pllLqFu+4Zv9EXcFMsURZ0heoaKm7NbP0cOiSWm0lgI=;
        b=vHVRkGqswdGDePe31dQV9XHpJJQAUlI9rUhP1I6etAcM4C6hVEyRG+X30Jjui368iZ
         nIlL1ryrnS/Tib7Vg6BPZ/1tQ2LU1fzYqbftv6N0P9JYbBy1fgoMAz2+bJv91/ZjNbnj
         cBxeM7I8m13asjK6wLu1Z+NVbhMPsMS8WNU00W24m3EMNQUEqoECIGWcBkeryLE+pQa1
         WsuonNr1DIM0gLmbl5j032i17L/SO6dEZYcCQqmh3/6/Y6LtLR2c6fypf3MQsgRNPWSQ
         fOxRJKeeSXXjWC4GhuLLo1eN4x5uFwtuPEM+rWeirs758DAH2ViC5NW8JMnnmaLBxw0T
         Itbg==
X-Forwarded-Encrypted: i=1; AKwUvBzppHg8X/cRU13mpi0snpjPuKrR6EmmM04+jP7Sg0fAvxFbyTh3nraqzj2xY1O9Fw6Xlh4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6N3Nc68BX9UCU9kvkiY8kL7TLAw4UEyTNhWE1G/L5/zsH7TTs
	pSbl57JmTvYJFonBhFRp8eYgWvE4BUgk0b5y//U28IIKAGYz6ks5HoYX
X-Gm-Gg: AYBFou13PrHoVwLiR7q5IaAFbivt7nOxVyp6S5tr6LKv3490izyQUbnxC4Ns2B4iVdG
	Y9LYmwjg/KrpZSIU1ZBcT+ot8nbyiRujm1VAyA52GBs3OwWgop8k5DKdV3uhJsGDSn/xWsDQ8Jl
	y6k1fEDm5YtDBxiM8PAQ+inoSa3bWzsyfsNH1Himo7d0apstBC/Eh/VDMCDiskNV91KtMBCRecT
	97e3qnBP2TorrpbZWsUBr7+06gC1w5AWYqRvyfJspnxiCF2G0s6RqdtvvUnfIVGTRZk+7z5hQTh
	SpznvESTqs4Si+pq27bZIzuYnO4CaEMBlbBqKJY8fC/oOpzJj9skDL1a9+nq43aTijp+XTEV8TW
	WW9YKkvZd4cPRWJROqSo2JZ1j/SWk8icWF1u6wvCShucchgRm6QriDQLv/ys+I78J2K4Kp/mfNh
	uNBHNKgTY7AKL0G58QUQpEqGsdHtLsl/Ok7WeDh67dTrIpsOO5RU1gLIE0akeCkXPVeCacoZWnB
	rkLL3jLx8hlJXmbiuIYi/wVXyNSaExoCcuJ71x1uscdKU64SYJM19cfssDIIcpJnjZiUG+Ya4E5
	hRtL6aeZ9jgwIvIF6TOEDVFbjvSGIsvkIIRqMQ2sBggji335ao+SrgsXUXIFcIgkLNkxCEzMmx8
	HzGdaa2HtP+tBRA4PmE/AN3e1xwm17ae+zg==
X-Received: by 2002:a17:90b:44:b0:3ab:ab5a:ef06 with SMTP id 98e67ed59e1d1-3ae896f832bmr13011731a91.12.1793759308868;
        Tue, 03 Nov 2026 18:28:28 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b096b6116bsm565015a91.4.2026.11.03.18.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 18:28:28 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 02:28:28 +0000
Message-Id: <DMM2LU4OE14Q.15KT5S3KNYPHX@gmail.com>
Cc: <qmo@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <ihor.solodrai@linux.dev>, <linux-kselftest@vger.kernel.org>,
 <skokovmaksimevg@gmail.com>, <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v10 3/4] bpftool: Add recursive map dumping
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tianyi Chen" <hi@tychen.cc>, <bpf@vger.kernel.org>
In-Reply-To: <8f2668ed4cd086f5fe3abb7ad0ca35066999ec49.1793732336.git.hi@tychen.cc>
References: <cover.1793732336.git.hi@tychen.cc> <8f2668ed4cd086f5fe3abb7ad0ca35066999ec49.1793732336.git.hi@tychen.cc>
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

On Tue, Nov 03, 2026 at 11:01 AM Tianyi Chen <hi@tychen.cc> wrote:
> Holding every discovered inner-map FD open would make descriptor use
> grow with the number of maps and could exhaust RLIMIT_NOFILE. Keep the
> selected map FDs open, queue distinct inner map IDs, and open, dump and
> close each queued map in turn. This needs only one additional map FD.
> The tradeoff is deferred ID resolution: concurrently removed inner
> maps can disappear before they are opened, so the dump is not atomic.

This is overkill.
The kernel has one level of map-in-map. bpf_map_meta_alloc() rejects
an inner map that has inner maps. Nothing recurses here.

Lets dump the inner map at the place that prints its id:
open it by id, dump it, close it. That's one more fd too.
These go away: struct map_dump_ctx, the hashmap, pending_ids,
plain_btf_wtr, the pass that records the selected maps,
the second loop in do_dump().
The selected fds don't have to stay open.

                      this patch               inner map in its entry
  ------------------  -----------------------  ------------------------
  json output         array of map objects,    same entries as without
                      the reader joins by id   'recursive', plus
                                               "inner_map"
  from id to open     all maps in front of it  nothing
                      in the queue are dumped
  inner map is gone   the whole dump fails     error in this entry,
                                               like a failed lookup
  shared inner map    printed once             printed in every entry

Inner maps get replaced on a live system. That's what map-in-map is for.
The longer the queue the more likely the dump fails.
The last row is the price. I think it's fine.

Something like this (not even compile tested):

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index e4ed7e7..0f0b1d9 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -29,7 +29,7 @@ MAP COMMANDS
 | **bpftool** **map create**     *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE* \
 |     **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] \
 |     [**offload_dev** *NAME*]
-| **bpftool** **map dump**       *MAP*
+| **bpftool** **map dump**       *MAP* [**recursive**]
 | **bpftool** **map update**     *MAP* [**key** *DATA*] [**value** *VALUE*] [*UPDATE_FLAGS*]
 | **bpftool** **map lookup**     *MAP* [**key** *DATA*]
 | **bpftool** **map getnext**    *MAP* [**key** *DATA*]
@@ -87,10 +87,13 @@ bpftool map create *FILE* type *TYPE* key *KEY_SIZE* value *VALUE_SIZE*  entries
     Keyword **offload_dev** expects a network interface name, and is used to
     request hardware offload for the map.

-bpftool map dump    *MAP*
+bpftool map dump    *MAP* [recursive]
     Dump all entries in a given *MAP*.  In case of **name**, *MAP* may match
     several maps which will all be dumped.

+    With **recursive**, an entry of an **array_of_maps** or a **hash_of_maps**
+    also has the dump of the inner map that it refers to.
+
 bpftool map update  *MAP* [key *DATA*] [value *VALUE*] [*UPDATE_FLAGS*]
     Update map entry for a given *KEY*.

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index a28af31..78fdb93 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -718,6 +718,9 @@ _bpftool()
                             return 0
                             ;;
                         *)
+                            if [[ $command == dump && $cword -eq 5 ]]; then
+                                COMPREPLY=( $( compgen -W 'recursive' -- "$cur" ) )
+                            fi
                             return 0
                             ;;
                     esac
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 4b65edf..0b3968b 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -22,6 +22,9 @@
 #include "main.h"

 static struct hashmap *map_table;
+static bool recursive_dump;
+
+static void dump_inner_map(__u32 id);

 static bool map_is_per_cpu(__u32 type)
 {
@@ -140,9 +143,14 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
 		print_hex_data_json(key, info->key_size);
 		jsonw_name(json_wtr, "value");
 		print_hex_data_json(value, info->value_size);
-		if (map_is_map_of_maps(info->type))
+		if (map_is_map_of_maps(info->type)) {
 			jsonw_uint_field(json_wtr, "inner_map_id",
 					 *(unsigned int *)value);
+			if (recursive_dump) {
+				jsonw_name(json_wtr, "inner_map");
+				dump_inner_map(*(unsigned int *)value);
+			}
+		}
 		if (btf) {
 			struct btf_dumper d = {
 				.btf = btf,
@@ -273,6 +281,8 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
 		}

 		printf("\n");
+		if (recursive_dump && map_is_map_of_maps(info->type))
+			dump_inner_map(*(unsigned int *)value);
 	} else {
 		unsigned int step;
 		int i;
@@ -929,6 +939,36 @@ exit_free:
 	return err;
 }

+/* The kernel has one level of map-in-map. An inner map has no inner maps. */
+static void dump_inner_map(__u32 id)
+{
+	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts, .open_flags = BPF_F_RDONLY);
+	struct bpf_map_info info = {};
+	json_writer_t *btf_wtr = NULL;
+	__u32 len = sizeof(info);
+	int fd;
+
+	fd = bpf_map_get_fd_by_id_opts(id, &opts);
+	if (fd < 0) {
+		p_err("can't get map by id (%u): %s", id, strerror(errno));
+		return;
+	}
+	if (bpf_map_get_info_by_fd(fd, &info, &len)) {
+		p_err("can't get map info: %s", strerror(errno));
+		goto out;
+	}
+
+	if (!json_output && info.btf_id)
+		btf_wtr = get_btf_writer();
+
+	map_dump(fd, &info, json_output ? json_wtr : btf_wtr, true);
+
+	if (btf_wtr)
+		jsonw_destroy(&btf_wtr);
+out:
+	close(fd);
+}
+
 static int do_dump(int argc, char **argv)
 {
 	json_writer_t *wtr = NULL, *btf_wtr = NULL;
@@ -938,8 +978,8 @@ static int do_dump(int argc, char **argv)
 	int *fds = NULL;
 	int err = -1;

-	if (argc != 2)
-		usage();
+	if (!REQ_ARGS(2))
+		return -1;

 	fds = malloc(sizeof(int));
 	if (!fds) {
@@ -950,6 +990,16 @@ static int do_dump(int argc, char **argv)
 	if (nb_fds < 1)
 		goto exit_free;

+	while (argc > 0) {
+		if (is_prefix(*argv, "recursive")) {
+			NEXT_ARG();
+			recursive_dump = true;
+		} else {
+			p_err("expected 'recursive', got: '%s'", *argv);
+			goto exit_close;
+		}
+	}
+
 	if (json_output) {
 		wtr = json_wtr;
 	} else {
@@ -994,6 +1044,7 @@ exit_close:
 exit_free:
 	free(fds);
 	free_btf_vmlinux();
+	recursive_dump = false;
 	return err;
 }

@@ -1502,7 +1553,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s create     FILE type TYPE key KEY_SIZE value VALUE_SIZE \\\n"
 		"                                  entries MAX_ENTRIES name NAME [flags FLAGS] \\\n"
 		"                                  [inner_map MAP] [offload_dev NAME]\n"
-		"       %1$s %2$s dump       MAP\n"
+		"       %1$s %2$s dump       MAP [recursive]\n"
 		"       %1$s %2$s update     MAP [key DATA] [value VALUE] [UPDATE_FLAGS]\n"
 		"       %1$s %2$s lookup     MAP [key DATA]\n"
 		"       %1$s %2$s getnext    MAP [key DATA]\n"

