Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0EAC43381
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 22:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05002186A
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 22:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glHGjscJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfCNWO6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:14:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40974 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfCNWO6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 18:14:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id k8so5731014oik.8;
        Thu, 14 Mar 2019 15:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LseI3QDNLfnowWZWaAugIkl1JYKIC4ov6uV0+naGyhI=;
        b=glHGjscJv1xnZ9Nx/3Ue5jHOEw0HBErfTArN6LKYUHWYTi3NKR7LwdWCZ4FwBo6T2e
         1ew+ycMsRDnKX5GxwsIuPBaobkpv+5Mh6GxGbp9EGjZ39oaTaRVQsjspIO4BEUMQod7d
         6k7g0yNKyQx+AbbY+g0KZyijwsLZAM89sa38vtRnSaqNNfAG85xafPJxdHGcm9tl2W8a
         uFZkpi5fTP/+ReuHB58GBZbv5S4yofwc3Wt3SqZWXzDkI4nHXUeCYaTwwu2xK+XpaFzs
         W0ZpGuuat53OnlBXWP98k4OHh6lGQ2pSoRbHRF2eQueqvseRKCsUEjxSX4zs5tTK5pbX
         TEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LseI3QDNLfnowWZWaAugIkl1JYKIC4ov6uV0+naGyhI=;
        b=kIkaty2st67+ghwUQq2MAnxRw2fg9KiY2RNF8Ol7EAxf4hmm2Cy/PtJWtVke+5W85T
         SX3KANlKv8TP7W3Tp8kdaSSouo8Txc0ZbOZEoEq0C/rfyarJgHtlKky/Bp7W1CPGDmb7
         7CHPSshidPYne1zwLfnlZiqjiLI9y2qjUX8/YJOcswwzUuj608utufwnTyYErM77exvI
         n4bxv7RkMhlMjyDpgHnveHSaMWKhtP9xrolLB0CFqbXcdhyHMXao7MJVJSE3cbKAz78j
         m/m2JB4zxw0v00WaYKk7RU52zVfMqcApzL5sgsPQvGCkJkGQbCw9Djr/s/uN7ZS7JcC9
         JHEw==
X-Gm-Message-State: APjAAAVeaY2ci8Kk7Rw5we7Tbvpx4Qrdn9oEKm7EuQAe192HtsfdXtGV
        eMNJLsPo3uRg6PGrh2QeFM6qTkqPRtIuqqoLGp8=
X-Google-Smtp-Source: APXvYqyNNTnx1N/DLHIImPRiOOoS3uEK4xB3f+kuxgwvcVYzBqEJTse6zWEpLRUsX/V9R/DwkyhFGLY0ND42FlE/gHA=
X-Received: by 2002:aca:3e54:: with SMTP id l81mr7795oia.10.1552601695680;
 Thu, 14 Mar 2019 15:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190311215125.17793-1-daniel@iogearbox.net> <20190311215125.17793-8-daniel@iogearbox.net>
In-Reply-To: <20190311215125.17793-8-daniel@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Mar 2019 15:14:43 -0700
Message-ID: <CAEf4BzbE35Br72kBFn3vi_AEPKR0uzqw-fgtKo=N0n0ebxY10A@mail.gmail.com>
Subject: Re: [PATCH rfc v3 bpf-next 7/9] bpf, libbpf: support global
 data/bss/rodata sections
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        john fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>, tgraf@suug.ch,
        lmb@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 11, 2019 at 2:51 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> This work adds BPF loader support for global data sections
> to libbpf. This allows to write BPF programs in more natural
> C-like way by being able to define global variables and const
> data.
>
> Back at LPC 2018 [0] we presented a first prototype which
> implemented support for global data sections by extending BPF
> syscall where union bpf_attr would get additional memory/size
> pair for each section passed during prog load in order to later
> add this base address into the ldimm64 instruction along with
> the user provided offset when accessing a variable. Consensus
> from LPC was that for proper upstream support, it would be
> more desirable to use maps instead of bpf_attr extension as
> this would allow for introspection of these sections as well
> as potential life updates of their content. This work follows

typo: live

> this path by taking the following steps from loader side:
>
>  1) In bpf_object__elf_collect() step we pick up ".data",
>     ".rodata", and ".bss" section information.
>
>  2) If present, in bpf_object__init_internal_map() we add
>     maps to the obj's map array that corresponds to each
>     of the present sections. Given section size and access
>     properties can differ, a single entry array map is
>     created with value size that is corresponding to the
>     ELF section size of .data, .bss or .rodata. These
>     internal maps are integrated into the normal map
>     handling of libbpf such that when user traverses all
>     obj maps, they can be differentiated from user-created
>     ones via bpf_map__is_internal(). In later steps when
>     we actually create these maps in the kernel via
>     bpf_object__create_maps(), then for .data and .rodata
>     sections their content is copied into the map through
>     bpf_map_update_elem(). For .bss this is not necessary
>     since array map is already zero-initialized by default.
>     Additionally, for .rodata the map is locked as read-only
>     after setup, such that neither from program nor syscall
>     side writes would be possible.
>
>  3) In bpf_program__collect_reloc() step, we record the
>     corresponding map, insn index, and relocation type for
>     the global data.
>
>  4) And last but not least in the actual relocation step in
>     bpf_program__relocate(), we mark the ldimm64 instruction
>     with src_reg = BPF_PSEUDO_MAP_VALUE where in the first
>     imm field the map's file descriptor is stored as similarly
>     done as in BPF_PSEUDO_MAP_FD, and in the second imm field
>     (as ldimm64 is 2-insn wide) we store the access offset
>     into the section. Given these maps have only single element
>     ldimm64's off remains zero in both parts.
>
>  5) On kernel side, this special marked BPF_PSEUDO_MAP_VALUE
>     load will then store the actual target address in order
>     to have a 'map-lookup'-free access. That is, the actual
>     map value base address + offset. The destination register
>     in the verifier will then be marked as PTR_TO_MAP_VALUE,
>     containing the fixed offset as reg->off and backing BPF
>     map as reg->map_ptr. Meaning, it's treated as any other
>     normal map value from verification side, only with
>     efficient, direct value access instead of actual call to
>     map lookup helper as in the typical case.
>
> Currently, only support for static global variables has been
> added, and libbpf rejects non-static global variables from
> loading. This can be lifted until we have proper semantics
> for how BPF will treat these.
>
> From BTF side, libbpf associates these three maps with BTF
> map name of ".bss", ".data" and ".rodata" which LLVM will
> emit (w/o the object name prefix).
>
> Simple example dump of program using globals vars in each
> section:
>
>   # bpftool prog
>   [...]
>   6784: sched_cls  name load_static_dat  tag a7e1291567277844  gpl
>         loaded_at 2019-03-11T15:39:34+0000  uid 0
>         xlated 1776B  jited 993B  memlock 4096B  map_ids 2238,2237,2235,2236,2239,2240
>
>   # bpftool map show id 2237
>   2237: array  name test_glo.bss  flags 0x0
>         key 4B  value 64B  max_entries 1  memlock 4096B
>   # bpftool map show id 2235
>   2235: array  name test_glo.data  flags 0x0
>         key 4B  value 64B  max_entries 1  memlock 4096B
>   # bpftool map show id 2236
>   2236: array  name test_glo.rodata  flags 0x80
>         key 4B  value 96B  max_entries 1  memlock 4096B
>
>   # bpftool prog dump xlated id 6784
>   int load_static_data(struct __sk_buff * skb):
>   ; int load_static_data(struct __sk_buff *skb)
>      0: (b7) r6 = 0
>   ; test_reloc(number, 0, &num0);
>      1: (63) *(u32 *)(r10 -4) = r6
>      2: (bf) r2 = r10
>   ; int load_static_data(struct __sk_buff *skb)
>      3: (07) r2 += -4
>   ; test_reloc(number, 0, &num0);
>      4: (18) r1 = map[id:2238]
>      6: (18) r3 = map[id:2237][0]+0    <-- direct addr in .bss area
>      8: (b7) r4 = 0
>      9: (85) call array_map_update_elem#100464
>     10: (b7) r1 = 1
>   ; test_reloc(number, 1, &num1);
>   [...]
>   ; test_reloc(string, 2, str2);
>    120: (18) r8 = map[id:2237][0]+16   <-- same here at offset +16
>    122: (18) r1 = map[id:2239]
>    124: (18) r3 = map[id:2237][0]+16
>    126: (b7) r4 = 0
>    127: (85) call array_map_update_elem#100464
>    128: (b7) r1 = 120
>   ; str1[5] = 'x';
>    129: (73) *(u8 *)(r9 +5) = r1
>   ; test_reloc(string, 3, str1);
>    130: (b7) r1 = 3
>    131: (63) *(u32 *)(r10 -4) = r1
>    132: (b7) r9 = 3
>    133: (bf) r2 = r10
>   ; int load_static_data(struct __sk_buff *skb)
>    134: (07) r2 += -4
>   ; test_reloc(string, 3, str1);
>    135: (18) r1 = map[id:2239]
>    137: (18) r3 = map[id:2235][0]+16   <-- direct addr in .data area
>    139: (b7) r4 = 0
>    140: (85) call array_map_update_elem#100464
>    141: (b7) r1 = 111
>   ; __builtin_memcpy(&str2[2], "hello", sizeof("hello"));
>    142: (73) *(u8 *)(r8 +6) = r1       <-- further access based on .bss data
>    143: (b7) r1 = 108
>    144: (73) *(u8 *)(r8 +5) = r1
>   [...]
>
> Based upon recent fix in LLVM, commit c0db6b6bd444 ("[BPF] Don't
> fail for static variables").
>
>   [0] LPC 2018, BPF track, "ELF relocation for static data in BPF",
>       http://vger.kernel.org/lpc-bpf2018.html#session-3
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>


This looks great, thanks! Pending on whatever you and Alexei decide
for bpf_map_lock:

Acked-by: Andrii Nakryiko <andriin@fb.com>

> ---
>  tools/lib/bpf/bpf.c      |  10 ++
>  tools/lib/bpf/bpf.h      |   1 +
>  tools/lib/bpf/libbpf.c   | 324 ++++++++++++++++++++++++++++++++++-----
>  tools/lib/bpf/libbpf.h   |   1 +
>  tools/lib/bpf/libbpf.map |   6 +
>  5 files changed, 301 insertions(+), 41 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9cd015574e83..cba2a615e135 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -429,6 +429,16 @@ int bpf_map_get_next_key(int fd, const void *key, void *next_key)
>         return sys_bpf(BPF_MAP_GET_NEXT_KEY, &attr, sizeof(attr));
>  }
>
> +int bpf_map_lock(int fd)
> +{
> +       union bpf_attr attr;
> +
> +       memset(&attr, 0, sizeof(attr));
> +       attr.map_fd = fd;
> +
> +       return sys_bpf(BPF_MAP_LOCK, &attr, sizeof(attr));
> +}
> +
>  int bpf_obj_pin(int fd, const char *pathname)
>  {
>         union bpf_attr attr;
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 6ffdd79bea89..fa2bdbba6f00 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -117,6 +117,7 @@ LIBBPF_API int bpf_map_lookup_and_delete_elem(int fd, const void *key,
>                                               void *value);
>  LIBBPF_API int bpf_map_delete_elem(int fd, const void *key);
>  LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
> +LIBBPF_API int bpf_map_lock(int fd);
>  LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
>  LIBBPF_API int bpf_obj_get(const char *pathname);
>  LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0afdb8914386..7821c9b1e838 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7,6 +7,7 @@
>   * Copyright (C) 2015 Wang Nan <wangnan0@huawei.com>
>   * Copyright (C) 2015 Huawei Inc.
>   * Copyright (C) 2017 Nicira, Inc.
> + * Copyright (C) 2019 Isovalent, Inc.
>   */
>
>  #ifndef _GNU_SOURCE
> @@ -139,6 +140,7 @@ struct bpf_program {
>                 enum {
>                         RELO_LD64,
>                         RELO_CALL,
> +                       RELO_DATA,
>                 } type;
>                 int insn_idx;
>                 union {
> @@ -171,6 +173,19 @@ struct bpf_program {
>         __u32 line_info_cnt;
>  };
>
> +enum libbpf_map_type {
> +       LIBBPF_MAP_UNSPEC,
> +       LIBBPF_MAP_DATA,
> +       LIBBPF_MAP_BSS,
> +       LIBBPF_MAP_RODATA,
> +};
> +
> +static const char *libbpf_type_to_btf_name[] = {
> +       [LIBBPF_MAP_DATA]       = ".data",
> +       [LIBBPF_MAP_BSS]        = ".bss",
> +       [LIBBPF_MAP_RODATA]     = ".rodata",
> +};
> +
>  struct bpf_map {
>         int fd;
>         char *name;
> @@ -182,11 +197,18 @@ struct bpf_map {
>         __u32 btf_value_type_id;
>         void *priv;
>         bpf_map_clear_priv_t clear_priv;
> +       enum libbpf_map_type libbpf_type;
> +};
> +
> +struct bpf_secdata {
> +       void *rodata;
> +       void *data;
>  };
>
>  static LIST_HEAD(bpf_objects_list);
>
>  struct bpf_object {
> +       char name[BPF_OBJ_NAME_LEN];
>         char license[64];
>         __u32 kern_version;
>
> @@ -194,6 +216,7 @@ struct bpf_object {
>         size_t nr_programs;
>         struct bpf_map *maps;
>         size_t nr_maps;
> +       struct bpf_secdata sections;
>
>         bool loaded;
>         bool has_pseudo_calls;
> @@ -209,6 +232,9 @@ struct bpf_object {
>                 Elf *elf;
>                 GElf_Ehdr ehdr;
>                 Elf_Data *symbols;
> +               Elf_Data *data;
> +               Elf_Data *rodata;
> +               Elf_Data *bss;
>                 size_t strtabidx;
>                 struct {
>                         GElf_Shdr shdr;
> @@ -217,6 +243,9 @@ struct bpf_object {
>                 int nr_reloc;
>                 int maps_shndx;
>                 int text_shndx;
> +               int data_shndx;
> +               int rodata_shndx;
> +               int bss_shndx;
>         } efile;
>         /*
>          * All loaded bpf_object is linked in a list, which is
> @@ -438,6 +467,7 @@ static struct bpf_object *bpf_object__new(const char *path,
>                                           size_t obj_buf_sz)
>  {
>         struct bpf_object *obj;
> +       char *end;
>
>         obj = calloc(1, sizeof(struct bpf_object) + strlen(path) + 1);
>         if (!obj) {
> @@ -446,8 +476,14 @@ static struct bpf_object *bpf_object__new(const char *path,
>         }
>
>         strcpy(obj->path, path);
> -       obj->efile.fd = -1;
> +       /* Using basename() GNU version which doesn't modify arg. */
> +       strncpy(obj->name, basename((void *)path),
> +               sizeof(obj->name) - 1);
> +       end = strchr(obj->name, '.');
> +       if (end)
> +               *end = 0;
>
> +       obj->efile.fd = -1;
>         /*
>          * Caller of this function should also calls
>          * bpf_object__elf_finish() after data collection to return
> @@ -457,6 +493,9 @@ static struct bpf_object *bpf_object__new(const char *path,
>         obj->efile.obj_buf = obj_buf;
>         obj->efile.obj_buf_sz = obj_buf_sz;
>         obj->efile.maps_shndx = -1;
> +       obj->efile.data_shndx = -1;
> +       obj->efile.rodata_shndx = -1;
> +       obj->efile.bss_shndx = -1;
>
>         obj->loaded = false;
>
> @@ -475,6 +514,9 @@ static void bpf_object__elf_finish(struct bpf_object *obj)
>                 obj->efile.elf = NULL;
>         }
>         obj->efile.symbols = NULL;
> +       obj->efile.data = NULL;
> +       obj->efile.rodata = NULL;
> +       obj->efile.bss = NULL;
>
>         zfree(&obj->efile.reloc);
>         obj->efile.nr_reloc = 0;
> @@ -616,27 +658,76 @@ static bool bpf_map_type__is_map_in_map(enum bpf_map_type type)
>         return false;
>  }
>
> +static bool bpf_object__has_maps(const struct bpf_object *obj)
> +{
> +       return obj->efile.maps_shndx >= 0 ||
> +              obj->efile.data_shndx >= 0 ||
> +              obj->efile.rodata_shndx >= 0 ||
> +              obj->efile.bss_shndx >= 0;
> +}
> +
> +static int
> +bpf_object__init_internal_map(struct bpf_object *obj, struct bpf_map *map,
> +                             enum libbpf_map_type type, Elf_Data *data,
> +                             void **data_buff)
> +{
> +       struct bpf_map_def *def = &map->def;
> +       char map_name[BPF_OBJ_NAME_LEN];
> +
> +       map->libbpf_type = type;
> +       map->offset = ~(typeof(map->offset))0;
> +       snprintf(map_name, sizeof(map_name), "%.8s%.7s", obj->name,
> +                libbpf_type_to_btf_name[type]);
> +       map->name = strdup(map_name);
> +       if (!map->name) {
> +               pr_warning("failed to alloc map name\n");
> +               return -ENOMEM;
> +       }
> +
> +       def->type = BPF_MAP_TYPE_ARRAY;
> +       def->key_size = sizeof(int);
> +       def->value_size = data->d_size;
> +       def->max_entries = 1;
> +       def->map_flags = type == LIBBPF_MAP_RODATA ?
> +                        BPF_F_RDONLY_PROG : 0;
> +       if (data_buff) {
> +               *data_buff = malloc(data->d_size);
> +               if (!*data_buff) {
> +                       zfree(&map->name);
> +                       pr_warning("failed to alloc map content buffer\n");
> +                       return -ENOMEM;
> +               }
> +               memcpy(*data_buff, data->d_buf, data->d_size);
> +       }
> +
> +       pr_debug("map %ld is \"%s\"\n", map - obj->maps, map->name);
> +       return 0;
> +}
> +
>  static int
>  bpf_object__init_maps(struct bpf_object *obj, int flags)
>  {
> +       int i, map_idx, map_def_sz, nr_syms, nr_maps = 0, nr_maps_glob = 0;
>         bool strict = !(flags & MAPS_RELAX_COMPAT);
> -       int i, map_idx, map_def_sz, nr_maps = 0;
> -       Elf_Scn *scn;
> -       Elf_Data *data;
>         Elf_Data *symbols = obj->efile.symbols;
> +       Elf_Data *data = NULL;
> +       int ret = 0;
>
> -       if (obj->efile.maps_shndx < 0)
> -               return -EINVAL;
>         if (!symbols)
>                 return -EINVAL;
> +       nr_syms = symbols->d_size / sizeof(GElf_Sym);
>
> -       scn = elf_getscn(obj->efile.elf, obj->efile.maps_shndx);
> -       if (scn)
> -               data = elf_getdata(scn, NULL);
> -       if (!scn || !data) {
> -               pr_warning("failed to get Elf_Data from map section %d\n",
> -                          obj->efile.maps_shndx);
> -               return -EINVAL;
> +       if (obj->efile.maps_shndx >= 0) {
> +               Elf_Scn *scn = elf_getscn(obj->efile.elf,
> +                                         obj->efile.maps_shndx);
> +
> +               if (scn)
> +                       data = elf_getdata(scn, NULL);
> +               if (!scn || !data) {
> +                       pr_warning("failed to get Elf_Data from map section %d\n",
> +                                  obj->efile.maps_shndx);
> +                       return -EINVAL;
> +               }
>         }
>
>         /*
> @@ -646,7 +737,13 @@ bpf_object__init_maps(struct bpf_object *obj, int flags)
>          *
>          * TODO: Detect array of map and report error.
>          */
> -       for (i = 0; i < symbols->d_size / sizeof(GElf_Sym); i++) {
> +       if (obj->efile.data_shndx >= 0)
> +               nr_maps_glob++;
> +       if (obj->efile.rodata_shndx >= 0)
> +               nr_maps_glob++;
> +       if (obj->efile.bss_shndx >= 0)
> +               nr_maps_glob++;
> +       for (i = 0; data && i < nr_syms; i++) {
>                 GElf_Sym sym;
>
>                 if (!gelf_getsym(symbols, i, &sym))
> @@ -659,19 +756,21 @@ bpf_object__init_maps(struct bpf_object *obj, int flags)
>         /* Alloc obj->maps and fill nr_maps. */
>         pr_debug("maps in %s: %d maps in %zd bytes\n", obj->path,
>                  nr_maps, data->d_size);
> -
> -       if (!nr_maps)
> +       if (!nr_maps && !nr_maps_glob)
>                 return 0;
>
>         /* Assume equally sized map definitions */
> -       map_def_sz = data->d_size / nr_maps;
> -       if (!data->d_size || (data->d_size % nr_maps) != 0) {
> -               pr_warning("unable to determine map definition size "
> -                          "section %s, %d maps in %zd bytes\n",
> -                          obj->path, nr_maps, data->d_size);
> -               return -EINVAL;
> +       if (data) {
> +               map_def_sz = data->d_size / nr_maps;
> +               if (!data->d_size || (data->d_size % nr_maps) != 0) {
> +                       pr_warning("unable to determine map definition size "
> +                                  "section %s, %d maps in %zd bytes\n",
> +                                  obj->path, nr_maps, data->d_size);
> +                       return -EINVAL;
> +               }
>         }
>
> +       nr_maps += nr_maps_glob;
>         obj->maps = calloc(nr_maps, sizeof(obj->maps[0]));
>         if (!obj->maps) {
>                 pr_warning("alloc maps for object failed\n");
> @@ -692,7 +791,7 @@ bpf_object__init_maps(struct bpf_object *obj, int flags)
>         /*
>          * Fill obj->maps using data in "maps" section.
>          */
> -       for (i = 0, map_idx = 0; i < symbols->d_size / sizeof(GElf_Sym); i++) {
> +       for (i = 0, map_idx = 0; data && i < nr_syms; i++) {
>                 GElf_Sym sym;
>                 const char *map_name;
>                 struct bpf_map_def *def;
> @@ -705,6 +804,8 @@ bpf_object__init_maps(struct bpf_object *obj, int flags)
>                 map_name = elf_strptr(obj->efile.elf,
>                                       obj->efile.strtabidx,
>                                       sym.st_name);
> +
> +               obj->maps[map_idx].libbpf_type = LIBBPF_MAP_UNSPEC;
>                 obj->maps[map_idx].offset = sym.st_value;
>                 if (sym.st_value + map_def_sz > data->d_size) {
>                         pr_warning("corrupted maps section in %s: last map \"%s\" too small\n",
> @@ -753,8 +854,27 @@ bpf_object__init_maps(struct bpf_object *obj, int flags)
>                 map_idx++;
>         }
>
> -       qsort(obj->maps, obj->nr_maps, sizeof(obj->maps[0]), compare_bpf_map);
> -       return 0;
> +       /*
> +        * Populate rest of obj->maps with libbpf internal maps.
> +        */
> +       if (obj->efile.data_shndx >= 0)
> +               ret = bpf_object__init_internal_map(obj, &obj->maps[map_idx++],
> +                                                   LIBBPF_MAP_DATA,
> +                                                   obj->efile.data,
> +                                                   &obj->sections.data);
> +       if (!ret && obj->efile.rodata_shndx >= 0)
> +               ret = bpf_object__init_internal_map(obj, &obj->maps[map_idx++],
> +                                                   LIBBPF_MAP_RODATA,
> +                                                   obj->efile.rodata,
> +                                                   &obj->sections.rodata);
> +       if (!ret && obj->efile.bss_shndx >= 0)
> +               ret = bpf_object__init_internal_map(obj, &obj->maps[map_idx++],
> +                                                   LIBBPF_MAP_BSS,
> +                                                   obj->efile.bss, NULL);
> +       if (!ret)
> +               qsort(obj->maps, obj->nr_maps, sizeof(obj->maps[0]),
> +                     compare_bpf_map);
> +       return ret;
>  }
>
>  static bool section_have_execinstr(struct bpf_object *obj, int idx)
> @@ -865,6 +985,14 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
>                                         pr_warning("failed to alloc program %s (%s): %s",
>                                                    name, obj->path, cp);
>                                 }
> +                       } else if (strcmp(name, ".data") == 0) {
> +                               obj->efile.data = data;
> +                               obj->efile.data_shndx = idx;
> +                       } else if (strcmp(name, ".rodata") == 0) {
> +                               obj->efile.rodata = data;
> +                               obj->efile.rodata_shndx = idx;
> +                       } else {
> +                               pr_debug("skip section(%d) %s\n", idx, name);
>                         }
>                 } else if (sh.sh_type == SHT_REL) {
>                         void *reloc = obj->efile.reloc;
> @@ -892,6 +1020,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
>                                 obj->efile.reloc[n].shdr = sh;
>                                 obj->efile.reloc[n].data = data;
>                         }
> +               } else if (sh.sh_type == SHT_NOBITS && strcmp(name, ".bss") == 0) {
> +                       obj->efile.bss = data;
> +                       obj->efile.bss_shndx = idx;
>                 } else {
>                         pr_debug("skip section(%d) %s\n", idx, name);
>                 }
> @@ -918,7 +1049,7 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
>                         }
>                 }
>         }
> -       if (obj->efile.maps_shndx >= 0) {
> +       if (bpf_object__has_maps(obj)) {
>                 err = bpf_object__init_maps(obj, flags);
>                 if (err)
>                         goto out;
> @@ -954,13 +1085,46 @@ bpf_object__find_program_by_title(struct bpf_object *obj, const char *title)
>         return NULL;
>  }
>
> +static bool bpf_object__shndx_is_data(const struct bpf_object *obj,
> +                                     int shndx)
> +{
> +       return shndx == obj->efile.data_shndx ||
> +              shndx == obj->efile.bss_shndx ||
> +              shndx == obj->efile.rodata_shndx;
> +}
> +
> +static bool bpf_object__shndx_is_maps(const struct bpf_object *obj,
> +                                     int shndx)
> +{
> +       return shndx == obj->efile.maps_shndx;
> +}
> +
> +static bool bpf_object__relo_in_known_section(const struct bpf_object *obj,
> +                                             int shndx)
> +{
> +       return shndx == obj->efile.text_shndx ||
> +              bpf_object__shndx_is_maps(obj, shndx) ||
> +              bpf_object__shndx_is_data(obj, shndx);
> +}
> +
> +static enum libbpf_map_type
> +bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
> +{
> +       if (shndx == obj->efile.data_shndx)
> +               return LIBBPF_MAP_DATA;
> +       else if (shndx == obj->efile.bss_shndx)
> +               return LIBBPF_MAP_BSS;
> +       else if (shndx == obj->efile.rodata_shndx)
> +               return LIBBPF_MAP_RODATA;
> +       else
> +               return LIBBPF_MAP_UNSPEC;
> +}
> +
>  static int
>  bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
>                            Elf_Data *data, struct bpf_object *obj)
>  {
>         Elf_Data *symbols = obj->efile.symbols;
> -       int text_shndx = obj->efile.text_shndx;
> -       int maps_shndx = obj->efile.maps_shndx;
>         struct bpf_map *maps = obj->maps;
>         size_t nr_maps = obj->nr_maps;
>         int i, nrels;
> @@ -980,7 +1144,10 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
>                 GElf_Sym sym;
>                 GElf_Rel rel;
>                 unsigned int insn_idx;
> +               unsigned int shdr_idx;
>                 struct bpf_insn *insns = prog->insns;
> +               enum libbpf_map_type type;
> +               const char *name;
>                 size_t map_idx;
>
>                 if (!gelf_getrel(data, i, &rel)) {
> @@ -995,13 +1162,18 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
>                                    GELF_R_SYM(rel.r_info));
>                         return -LIBBPF_ERRNO__FORMAT;
>                 }
> -               pr_debug("relo for %lld value %lld name %d\n",
> +
> +               name = elf_strptr(obj->efile.elf, obj->efile.strtabidx,
> +                                 sym.st_name) ? : "<?>";
> +
> +               pr_debug("relo for %lld value %lld name %d (\'%s\')\n",
>                          (long long) (rel.r_info >> 32),
> -                        (long long) sym.st_value, sym.st_name);
> +                        (long long) sym.st_value, sym.st_name, name);
>
> -               if (sym.st_shndx != maps_shndx && sym.st_shndx != text_shndx) {
> -                       pr_warning("Program '%s' contains non-map related relo data pointing to section %u\n",
> -                                  prog->section_name, sym.st_shndx);
> +               shdr_idx = sym.st_shndx;
> +               if (!bpf_object__relo_in_known_section(obj, shdr_idx)) {
> +                       pr_warning("Program '%s' contains unrecognized relo data pointing to section %u\n",
> +                                  prog->section_name, shdr_idx);
>                         return -LIBBPF_ERRNO__RELOC;
>                 }
>
> @@ -1026,10 +1198,22 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
>                         return -LIBBPF_ERRNO__RELOC;
>                 }
>
> -               if (sym.st_shndx == maps_shndx) {
> -                       /* TODO: 'maps' is sorted. We can use bsearch to make it faster. */
> +               if (bpf_object__shndx_is_maps(obj, shdr_idx) ||
> +                   bpf_object__shndx_is_data(obj, shdr_idx)) {
> +                       type = bpf_object__section_to_libbpf_map_type(obj, shdr_idx);
> +                       if (type != LIBBPF_MAP_UNSPEC &&
> +                           GELF_ST_BIND(sym.st_info) == STB_GLOBAL) {
> +                               pr_warning("bpf: relocation: not yet supported relo for non-static global \'%s\' variable found in insns[%d].code 0x%x\n",
> +                                          name, insn_idx, insns[insn_idx].code);
> +                               return -LIBBPF_ERRNO__RELOC;
> +                       }
> +
>                         for (map_idx = 0; map_idx < nr_maps; map_idx++) {
> -                               if (maps[map_idx].offset == sym.st_value) {
> +                               if (maps[map_idx].libbpf_type != type)
> +                                       continue;
> +                               if (type != LIBBPF_MAP_UNSPEC ||
> +                                   (type == LIBBPF_MAP_UNSPEC &&
> +                                    maps[map_idx].offset == sym.st_value)) {
>                                         pr_debug("relocation: find map %zd (%s) for insn %u\n",
>                                                  map_idx, maps[map_idx].name, insn_idx);
>                                         break;
> @@ -1042,7 +1226,8 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
>                                 return -LIBBPF_ERRNO__RELOC;
>                         }
>
> -                       prog->reloc_desc[i].type = RELO_LD64;
> +                       prog->reloc_desc[i].type = type != LIBBPF_MAP_UNSPEC ?
> +                                                  RELO_DATA : RELO_LD64;
>                         prog->reloc_desc[i].insn_idx = insn_idx;
>                         prog->reloc_desc[i].map_idx = map_idx;
>                 }
> @@ -1050,13 +1235,25 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
>         return 0;
>  }
>
> +static const char *bpf_map___btf_name(struct bpf_map *map)
> +{
> +       if (!bpf_map__is_internal(map))
> +               return map->name;
> +       /*
> +        * LLVM annotates global data differently in BTF, that is,
> +        * only as '.data', '.bss' or '.rodata'.
> +        */
> +       return libbpf_type_to_btf_name[map->libbpf_type];
> +}
> +
>  static int bpf_map_find_btf_info(struct bpf_map *map, const struct btf *btf)
>  {
> +       const char *name = bpf_map___btf_name(map);
>         struct bpf_map_def *def = &map->def;
>         __u32 key_type_id, value_type_id;
>         int ret;
>
> -       ret = btf__get_map_kv_tids(btf, map->name, def->key_size,
> +       ret = btf__get_map_kv_tids(btf, name, def->key_size,
>                                    def->value_size, &key_type_id,
>                                    &value_type_id);
>         if (ret)
> @@ -1175,6 +1372,25 @@ bpf_object__probe_caps(struct bpf_object *obj)
>         return bpf_object__probe_name(obj);
>  }
>
> +static int
> +bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
> +{
> +       int err, zero = 0;
> +       __u8 *data;
> +
> +       /* Nothing to do here since kernel already zero-initializes .bss map. */
> +       if (map->libbpf_type == LIBBPF_MAP_BSS)
> +               return 0;
> +
> +       data = map->libbpf_type == LIBBPF_MAP_DATA ?
> +              obj->sections.data : obj->sections.rodata;
> +       err = bpf_map_update_elem(map->fd, &zero, data, 0);
> +       /* Lock .rodata map as read-only from syscall side. */
> +       if (!err && map->libbpf_type == LIBBPF_MAP_RODATA)
> +               err = bpf_map_lock(map->fd);
> +       return err;
> +}
> +
>  static int
>  bpf_object__create_maps(struct bpf_object *obj)
>  {
> @@ -1232,6 +1448,7 @@ bpf_object__create_maps(struct bpf_object *obj)
>                         size_t j;
>
>                         err = *pfd;
> +err_out:
>                         cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
>                         pr_warning("failed to create map (name: '%s'): %s\n",
>                                    map->name, cp);
> @@ -1239,6 +1456,15 @@ bpf_object__create_maps(struct bpf_object *obj)
>                                 zclose(obj->maps[j].fd);
>                         return err;
>                 }
> +
> +               if (bpf_map__is_internal(map)) {
> +                       err = bpf_object__populate_internal_map(obj, map);
> +                       if (err < 0) {
> +                               zclose(*pfd);
> +                               goto err_out;
> +                       }
> +               }
> +
>                 pr_debug("create map %s: fd=%d\n", map->name, *pfd);
>         }
>
> @@ -1393,19 +1619,27 @@ bpf_program__relocate(struct bpf_program *prog, struct bpf_object *obj)
>                 return 0;
>
>         for (i = 0; i < prog->nr_reloc; i++) {
> -               if (prog->reloc_desc[i].type == RELO_LD64) {
> +               if (prog->reloc_desc[i].type == RELO_LD64 ||
> +                   prog->reloc_desc[i].type == RELO_DATA) {
> +                       bool relo_data = prog->reloc_desc[i].type == RELO_DATA;
>                         struct bpf_insn *insns = prog->insns;
>                         int insn_idx, map_idx;
>
>                         insn_idx = prog->reloc_desc[i].insn_idx;
>                         map_idx = prog->reloc_desc[i].map_idx;
>
> -                       if (insn_idx >= (int)prog->insns_cnt) {
> +                       if (insn_idx + 1 >= (int)prog->insns_cnt) {
>                                 pr_warning("relocation out of range: '%s'\n",
>                                            prog->section_name);
>                                 return -LIBBPF_ERRNO__RELOC;
>                         }
> -                       insns[insn_idx].src_reg = BPF_PSEUDO_MAP_FD;
> +
> +                       if (!relo_data) {
> +                               insns[insn_idx].src_reg = BPF_PSEUDO_MAP_FD;
> +                       } else {
> +                               insns[insn_idx].src_reg = BPF_PSEUDO_MAP_VALUE;
> +                               insns[insn_idx + 1].imm = insns[insn_idx].imm;
> +                       }
>                         insns[insn_idx].imm = obj->maps[map_idx].fd;
>                 } else if (prog->reloc_desc[i].type == RELO_CALL) {
>                         err = bpf_program__reloc_text(prog, obj,
> @@ -2291,6 +2525,9 @@ void bpf_object__close(struct bpf_object *obj)
>                 obj->maps[i].priv = NULL;
>                 obj->maps[i].clear_priv = NULL;
>         }
> +
> +       zfree(&obj->sections.rodata);
> +       zfree(&obj->sections.data);
>         zfree(&obj->maps);
>         obj->nr_maps = 0;
>
> @@ -2768,6 +3005,11 @@ bool bpf_map__is_offload_neutral(struct bpf_map *map)
>         return map->def.type == BPF_MAP_TYPE_PERF_EVENT_ARRAY;
>  }
>
> +bool bpf_map__is_internal(struct bpf_map *map)
> +{
> +       return map->libbpf_type != LIBBPF_MAP_UNSPEC;
> +}
> +
>  void bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex)
>  {
>         map->map_ifindex = ifindex;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b4652aa1a58a..6e162da8e9f9 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -300,6 +300,7 @@ LIBBPF_API void *bpf_map__priv(struct bpf_map *map);
>  LIBBPF_API int bpf_map__reuse_fd(struct bpf_map *map, int fd);
>  LIBBPF_API int bpf_map__resize(struct bpf_map *map, __u32 max_entries);
>  LIBBPF_API bool bpf_map__is_offload_neutral(struct bpf_map *map);
> +LIBBPF_API bool bpf_map__is_internal(struct bpf_map *map);
>  LIBBPF_API void bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex);
>  LIBBPF_API int bpf_map__pin(struct bpf_map *map, const char *path);
>  LIBBPF_API int bpf_map__unpin(struct bpf_map *map, const char *path);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 778a26702a70..3f493f3520c9 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -154,3 +154,9 @@ LIBBPF_0.0.2 {
>                 xsk_umem__fd;
>                 xsk_socket__fd;
>  } LIBBPF_0.0.1;
> +
> +LIBBPF_0.0.3 {
> +       global:
> +               bpf_map__is_internal;
> +               bpf_map_lock;
> +} LIBBPF_0.0.2;
> --
> 2.17.1
>
