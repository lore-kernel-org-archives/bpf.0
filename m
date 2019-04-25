Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD908C43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EEB206BA
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="U+bmBhxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDYTVA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:21:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38444 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfDYTU7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 15:20:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so795239wmc.3
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 12:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jZ9qAqJlvJ067ilBHo/xJj5uEEX8hhix3EyFrhcfSG4=;
        b=U+bmBhxys8Wbg9YM/XBJJQ4hDhf8LihRvs9ZJpgj6UiUdeyUnmE5qEzpfTt1TgnBIU
         JhV13peYcFZfEqUXCiUaYDv5hctfKzgmkSQ/GmCpS1f+/ZxHBav5CWLuIWYlItVwvkvM
         qEFK9DKBsqF7HfALhDIuSnxaUvJ+p5rGJJOjBxiq8QkhzoIrCUTuEUqkm4iWpltK/BZ6
         0pgIrvyg8FV4d4yW9xNacQ+CAqSlv4vWpGB8crHgH3/oAzZmKxh+Re6J9lUdfKl0NWC0
         CPSi5dBAa+JTCkP83fngmgCMQ7YVbwQS30LpZLTfphhyt77nUMA7Z8jzK+LUZPgs+IkD
         HREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jZ9qAqJlvJ067ilBHo/xJj5uEEX8hhix3EyFrhcfSG4=;
        b=uDOL9AzmR3C8kBJdQMyZNXPAwAcdo0ijCCddhFw7ZTXW/30Xo3x7maoahth2aRsn1f
         J0I2D5bYSYnAnWotA0TuKdxftTf2H2h6je5rZurmyx/raUpZQc9GCz/NJHAUORei8qxf
         3wdqK9lfWtspNnGlJ6CMZJ3aCrG+jJA2dq/sXwTZNqMPkrT2rsJW1kFileniZdmgFuzh
         6GfL5W7qOVjTlamb/Jl0NfnaSqeewaA0uiX1p984LVdpLIQLDy7PEhjV3z65agEqFsBO
         aS3KWS9GeV9UBw4PzGUUwfZtX2jxuZfIje+MvaVvpql65sgsXeof0+XuATEjyYu19czc
         9M/g==
X-Gm-Message-State: APjAAAXsaYSShLl70eU92sYZcM8cc2nvEeM7GWBc/SLCZ1xlXgFhvgS5
        QoBz303KjQw6RYPCAgbni71Osg==
X-Google-Smtp-Source: APXvYqx0upOAIxhVC14jUfVcGsHYtuOm9lhIcBcX5EfNWZLiUruHSC8x9unytZ+u7ncVH9BKZNxcig==
X-Received: by 2002:a05:600c:249:: with SMTP id 9mr4726218wmj.149.1556220057443;
        Thu, 25 Apr 2019 12:20:57 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.213])
        by smtp.gmail.com with ESMTPSA id g185sm10309961wmf.30.2019.04.25.12.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:20:56 -0700 (PDT)
Subject: Re: [PATCH v3 bpf-next 2/4] bpftool/docs: add btf sub-command
 documentation
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        kernel-team@fb.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        ast@fb.com, daniel@iogearbox.net, yhs@fb.com,
        songliubraving@fb.com, kafai@fb.com, acme@kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20190425165539.3317350-1-andriin@fb.com>
 <20190425165539.3317350-3-andriin@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <06ca428a-727c-8f50-9daa-921d95103029@netronome.com>
Date:   Thu, 25 Apr 2019 20:20:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425165539.3317350-3-andriin@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-04-25 09:55 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Document usage and sample output format for `btf dump` sub-command.
> 
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>   .../bpf/bpftool/Documentation/bpftool-btf.rst | 205 ++++++++++++++++++
>   .../bpftool/Documentation/bpftool-cgroup.rst  |   3 +-
>   .../bpftool/Documentation/bpftool-feature.rst |   3 +-
>   .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
>   .../bpf/bpftool/Documentation/bpftool-net.rst |   3 +-
>   .../bpftool/Documentation/bpftool-perf.rst    |   3 +-
>   .../bpftool/Documentation/bpftool-prog.rst    |   3 +-
>   tools/bpf/bpftool/Documentation/bpftool.rst   |   3 +-
>   8 files changed, 219 insertions(+), 7 deletions(-)
>   create mode 100644 tools/bpf/bpftool/Documentation/bpftool-btf.rst
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> new file mode 100644
> index 000000000000..d37d782a1cfb
> --- /dev/null
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -0,0 +1,205 @@
> +================
> +bpftool-btf
> +================
> +-------------------------------------------------------------------------------
> +tool for inspection of BTF data
> +-------------------------------------------------------------------------------
> +
> +:Manual section: 8
> +
> +SYNOPSIS
> +========
> +
> +	**bpftool** [*OPTIONS*] **btf** *COMMAND*
> +
> +	*OPTIONS* := { { **-j** | **--json** } [{ **-p** | **--pretty** }] }
> +
> +	*COMMANDS* :=
> +	{ **dump** | **help** }

Commands fit on a single line.

> +
> +MAP COMMANDS
> +=============
> +
> +|	**bpftool** **btf dump**       *BTF_SRC*

Why so much space between "dump" and "BTF_SRC"? Is it to make it easier 
to align it if other commands are added in the future? For now it looks 
a bit strange in my opinion.

> +|	**bpftool** **btf help**
> +|
> +|	*BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
> +|	*MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
> +|	*PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
> +
> +DESCRIPTION
> +===========
> +	**bpftool map dump**    *MAP*

That's a lot of space again. I think you copied it from bpftool-map.rst. 
But it looks like you forgot to replace "map dump MAP" with "btf dump 
BTF_SRC" :).

A brief description of key/value/kv/all, or of what kind of FILE is 
expected, would be welcome here.

> +		  Dump BTF entries from a given *BTF_SRC*.
> +
> +	**bpftool map help**

"bpftool btf help"

> +		  Print short help message.
> +
> +OPTIONS
> +=======
> +	-h, --help
> +		  Print short generic help message (similar to **bpftool help**).
> +
> +	-V, --version
> +		  Print version number (similar to **bpftool version**).
> +
> +	-j, --json
> +		  Generate JSON output. For commands that cannot produce JSON, this
> +		  option has no effect.
> +
> +	-p, --pretty
> +		  Generate human-readable JSON output. Implies **-j**.
> +
> +EXAMPLES
> +========
> +**# bpftool btf dump id 1226**
> +::
> +
> +  [1] PTR '(anon)' type_id=2
> +  [2] STRUCT 'dummy_tracepoint_args' size=16 vlen=2
> +          'pad' type_id=3 bits_offset=0
> +          'sock' type_id=4 bits_offset=64
> +  [3] INT 'long long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> +  [4] PTR '(anon)' type_id=5
> +  [5] FWD 'sock' fwd_kind=union
> +
> +This gives an example of default output for all supported BTF kinds.
> +
> +**$ cat prog.c**
> +::
> +
> +  struct fwd_struct;
> +
> +  enum my_enum {
> +          VAL1 = 3,
> +          VAL2 = 7,
> +  };
> +
> +  typedef struct my_struct my_struct_t;
> +
> +  struct my_struct {
> +          const unsigned int const_int_field;
> +          int bitfield_field: 4;
> +          char arr_field[16];
> +          const struct fwd_struct *restrict fwd_field;
> +          enum my_enum enum_field;
> +          volatile my_struct_t *typedef_ptr_field;
> +  };
> +
> +  union my_union {
> +          int a;
> +          struct my_struct b;
> +  };
> +
> +  struct my_struct struct_global_var __attribute__((section("data_sec"))) = {
> +          .bitfield_field = 3,
> +          .enum_field = VAL1,
> +  };
> +  int global_var __attribute__((section("data_sec"))) = 7;
> +
> +  __attribute__((noinline))
> +  int my_func(union my_union *arg1, int arg2)
> +  {
> +          static int static_var __attribute__((section("data_sec"))) = 123;
> +          static_var++;
> +          return static_var;
> +  }
> +
> +**$ bpftool btf dump file prog.o**
> +::
> +
> +  [1] PTR '(anon)' type_id=2
> +  [2] UNION 'my_union' size=48 vlen=2
> +          'a' type_id=3 bits_offset=0
> +          'b' type_id=4 bits_offset=0
> +  [3] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> +  [4] STRUCT 'my_struct' size=48 vlen=6
> +          'const_int_field' type_id=5 bits_offset=0
> +          'bitfield_field' type_id=3 bits_offset=32 bitfield_size=4
> +          'arr_field' type_id=8 bits_offset=40
> +          'fwd_field' type_id=10 bits_offset=192
> +          'enum_field' type_id=14 bits_offset=256
> +          'typedef_ptr_field' type_id=15 bits_offset=320
> +  [5] CONST '(anon)' type_id=6
> +  [6] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> +  [7] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
> +  [8] ARRAY '(anon)' type_id=7 index_type_id=9 nr_elems=16
> +  [9] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> +  [10] RESTRICT '(anon)' type_id=11
> +  [11] PTR '(anon)' type_id=12
> +  [12] CONST '(anon)' type_id=13
> +  [13] FWD 'fwd_struct' fwd_kind=union
> +  [14] ENUM 'my_enum' size=4 vlen=2
> +          'VAL1' val=3
> +          'VAL2' val=7
> +  [15] PTR '(anon)' type_id=16
> +  [16] VOLATILE '(anon)' type_id=17
> +  [17] TYPEDEF 'my_struct_t' type_id=4
> +  [18] FUNC_PROTO '(anon)' ret_type_id=3 vlen=2
> +          'arg1' type_id=1
> +          'arg2' type_id=3
> +  [19] FUNC 'my_func' type_id=18
> +  [20] VAR 'struct_global_var' type_id=4, linkage=global-alloc
> +  [21] VAR 'global_var' type_id=3, linkage=global-alloc
> +  [22] VAR 'my_func.static_var' type_id=3, linkage=static
> +  [23] DATASEC 'data_sec' size=0 vlen=3
> +          type_id=20 offset=0 size=48
> +          type_id=21 offset=0 size=4
> +          type_id=22 offset=52 size=4
> +
> +The following commands print BTF types associated with specified map's key,
> +value, both key and value, and all BTF types, respectively. By default, both
> +key and value types will be printed.

This kind of info should go into the command's description (although I 
don't mind if we also repeat it here).

> +
> +**# bpftool btf dump map id 123 key**
> +
> +::
> +
> +  [39] TYPEDEF 'u32' type_id=37
> +
> +**# bpftool btf dump map id 123 value**
> +
> +::
> +
> +  [86] PTR '(anon)' type_id=87
> +
> +**# bpftool btf dump map id 123 kv**
> +
> +::
> +
> +  [39] TYPEDEF 'u32' type_id=37
> +  [86] PTR '(anon)' type_id=87
> +
> +**# bpftool btf dump map id 123 all**
> +
> +::
> +
> +  [1] PTR '(anon)' type_id=0
> +  .
> +  .
> +  .
> +  [2866] ARRAY '(anon)' type_id=52 index_type_id=51 nr_elems=4
> +
> +All the standard ways to specify map or program is supported:

s/is/are/

> +
> +**# bpftool btf dump map id 123**
> +
> +**# bpftool btf dump map pinned /sys/fs/bpf/map_name**
> +
> +**# bpftool btf dump prog id 456**
> +
> +**# bpftool btf dump prog tag b88e0a09b1d9759d**
> +
> +**# bpftool btf dump prog pinned /sys/fs/bpf/prog_name**
> +
> +SEE ALSO
> +========
