Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282E7C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 18:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEF720842
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 18:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="WhpyiT9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfCASKi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:10:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36754 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfCASKi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 13:10:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so11784700pfa.3
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rB+YiAKEYHV1/a2xml5oJegLJckiOvkGtIShDnM4tEM=;
        b=WhpyiT9Ln+iigm/x37Ac1/YHETumE+AasoAKVJatBw06mz5F8RBVTgdq2tlZEnSvj+
         HAU7pENNIgh8byGX77IhpGjhVkgeEt196kozAZT86un2YDg7xvD2aEko8sNOqYIcUPZb
         9280ev2k2PO0XTvI8JiPyrJ655HibbvWuMs7WZVeCL6dHCuVYyWIRELxplW9/3WLumTz
         Fuc0sh5Z/wfBmPl17plrNXbsCJlsN08P/2sxJrk/BrPEUPC0lSsgqwMQnGwDsbRCML6+
         sAsLBJ3WbGShiUKDnLu3IStwowFN14QlgcMcoxUI/GBOIHDMUGp5oPgn6DplxyeIveXx
         3R+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rB+YiAKEYHV1/a2xml5oJegLJckiOvkGtIShDnM4tEM=;
        b=ml+50zo9g6KI1oukeamWLcfOkclrPY4c5F8OpFIl4+1ttodJzyt4XuLdWL68I7molX
         9kk65OnD+Urr9YRguNG3M4YDO3yXO0y5Ot+3pIf72ufDdUYc4/aUNon/pLs/bOenSwIu
         ZMjGd9X8tk77F5WIuTNuLjUt0bTPbiiCgnC7BWcJcCtTmdWWNw6odPzPwJ1+c7V3MyCw
         RaCIdzxdfO8RBYDpeT3Ly4NvitHOuL0fbfM7n5QDw421re67PXTzRm/OhcOT+BfYk11v
         QFTgpUCy8OPQrMVdLsId0NW+oh0nOqCXgIDNdR4IVIO1FPJxWz7jlQ51dh0eLTPVb6f+
         f1Bg==
X-Gm-Message-State: APjAAAXicyxHnr58N8leTkmCK91ydbKL/KIdUywn7bXPVNlmNguItjka
        v05nZHK5CS75ugJfI7JC5efTQA==
X-Google-Smtp-Source: APXvYqwQ5W8i3Z5Zc6ChL3EDmNBpry0Z4aLij6kkBQl3XsOQezQ1EEuRlvv+zUY/roNwx/VP+f3RkQ==
X-Received: by 2002:a63:4e05:: with SMTP id c5mr6132254pgb.393.1551463835980;
        Fri, 01 Mar 2019 10:10:35 -0800 (PST)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id g6sm30314138pgc.22.2019.03.01.10.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 10:10:35 -0800 (PST)
Date:   Fri, 1 Mar 2019 10:10:34 -0800
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@fb.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, joe@wand.net.nz,
        john.fastabend@gmail.com, tgraf@suug.ch,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        lmb@cloudflare.com
Subject: Re: [PATCH bpf-next v2 5/7] bpf, libbpf: support global
 data/bss/rodata sections
Message-ID: <20190301181034.GB10108@mini-arch.hsd1.ca.comcast.net>
References: <20190228231829.11993-1-daniel@iogearbox.net>
 <20190228231829.11993-6-daniel@iogearbox.net>
 <CAEf4BzaLKud9dJbJLXVpZ01U5Q3fF6epL1jtpkCs_n3bqs09HQ@mail.gmail.com>
 <167d6a8f-82b3-0bd7-5399-e51f4de6a790@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167d6a8f-82b3-0bd7-5399-e51f4de6a790@iogearbox.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/01, Daniel Borkmann wrote:
> On 03/01/2019 07:53 AM, Andrii Nakryiko wrote:
> > On Thu, Feb 28, 2019 at 3:31 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>
> >> This work adds BPF loader support for global data sections
> >> to libbpf. This allows to write BPF programs in more natural
> >> C-like way by being able to define global variables and const
> >> data.
> >>
> >> Back at LPC 2018 [0] we presented a first prototype which
> >> implemented support for global data sections by extending BPF
> >> syscall where union bpf_attr would get additional memory/size
> >> pair for each section passed during prog load in order to later
> >> add this base address into the ldimm64 instruction along with
> >> the user provided offset when accessing a variable. Consensus
> >> from LPC was that for proper upstream support, it would be
> >> more desirable to use maps instead of bpf_attr extension as
> >> this would allow for introspection of these sections as well
> >> as potential life updates of their content. This work follows
> >> this path by taking the following steps from loader side:
> >>
> >>  1) In bpf_object__elf_collect() step we pick up ".data",
> >>     ".rodata", and ".bss" section information.
> >>
> >>  2) If present, in bpf_object__init_global_maps() we create
> >>     a map that corresponds to each of the present sections.
> > 
> > Is there any point in having .data and .bss in separate maps? I can
> > only see for reasons of inspectiion from bpftool, but other than that
> > isn't .bss just an optimization over .data to save space in ELF file,
> > but in other regards is just another part of r/w .data section?
> 
> Hmm, I actually don't mind too much combining both of them. Had
> the same thought with regards to introspection from bpftool which
> was why I separated them. But combining the two into a single map
> is fine actually, saves a bit of resources in kernel, and offsets
> can easily be fixed up from libbpf side. Will do for v3.
Do we plan to pretty-print data/bss with BTF from the bpftool at some
point? Does combining them makes it harder?

> >>     Given section size and access properties can differ, a
> >>     single entry array map is created with value size that
> >>     is corresponding to the ELF section size of .data, .bss
> >>     or .rodata. In the latter case, the map is created as
> >>     read-only from program side such that verifier rejects
> >>     any write attempts into .rodata. In a subsequent step,
> >>     for .data and .rodata sections, the section content is
> >>     copied into the map through bpf_map_update_elem(). For
> >>     .bss this is not necessary since array map is already
> >>     zero-initialized by default.
> > 
> > For .rodata, ideally it would be nice to make it RDONLY from userland
> > as well, except for first UPDATE. How hard is it to support that?
> 
> Right now the BPF_F_RDONLY, BPF_F_WRONLY semantics to make the
> maps read-only or write-only from syscall side are that these
> permissions are stored into the struct file front end (file->f_mode)
> for the anon inode we use, meaning it's separated from the actual
> BPF map, so you can create the map with BPF_F_RDONLY, but root
> user can do BPF_MAP_GET_FD_BY_ID without the BPF_F_RDONLY and
> again write into it. This design choice would require that we'd
> need to add some additional infrastructure on top of this, which
> would then need to enforce file->f_mode to read-only after the
> first setup. I think there's simple trick we can apply to make
> it read-only after setup from syscall side: we'll add a new flag
> to the map, and then upon map creation libbpf sets everything
> up, holds the id, closes its fd, and refetches the fd by id.
> From that point onwards any interface where you would get the
> fd from the map in user space will enforce BPF_F_RDONLY behavior
> for file->f_mode. Another, less hacky option could be to extend
> the struct file ops we currently use for BPF maps and set a
> map 'immutable' flag from there which is then enforced once all
> pending operations have completed. I can look a bit into this.
> 
> >>  3) In bpf_program__collect_reloc() step, we record the
> >>     corresponding map, insn index, and relocation type for
> >>     the global data.
> >>
> >>  4) And last but not least in the actual relocation step in
> >>     bpf_program__relocate(), we mark the ldimm64 instruction
> >>     with src_reg = BPF_PSEUDO_MAP_VALUE where in the first
> >>     imm field the map's file descriptor is stored as similarly
> >>     done as in BPF_PSEUDO_MAP_FD, and in the second imm field
> >>     (as ldimm64 is 2-insn wide) we store the access offset
> >>     into the section.
> >>
> >>  5) On kernel side, this special marked BPF_PSEUDO_MAP_VALUE
> >>     load will then store the actual target address in order
> >>     to have a 'map-lookup'-free access. That is, the actual
> >>     map value base address + offset. The destination register
> >>     in the verifier will then be marked as PTR_TO_MAP_VALUE,
> >>     containing the fixed offset as reg->off and backing BPF
> >>     map as reg->map_ptr. Meaning, it's treated as any other
> >>     normal map value from verification side, only with
> >>     efficient, direct value access instead of actual call to
> >>     map lookup helper as in the typical case.
> >>
> >> Simple example dump of program using globals vars in each
> >> section:
> >>
> >>   # readelf -a test_global_data.o
> >>   [...]
> >>   [ 6] .bss              NOBITS           0000000000000000  00000328
> >>        0000000000000010  0000000000000000  WA       0     0     8
> >>   [ 7] .data             PROGBITS         0000000000000000  00000328
> >>        0000000000000010  0000000000000000  WA       0     0     8
> >>   [ 8] .rodata           PROGBITS         0000000000000000  00000338
> >>        0000000000000018  0000000000000000   A       0     0     8
> >>   [...]
> >>     95: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    6 static_bss
> >>     96: 0000000000000008     8 OBJECT  LOCAL  DEFAULT    6 static_bss2
> >>     97: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    7 static_data
> >>     98: 0000000000000008     8 OBJECT  LOCAL  DEFAULT    7 static_data2
> >>     99: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    8 static_rodata
> >>    100: 0000000000000008     8 OBJECT  LOCAL  DEFAULT    8 static_rodata2
> >>    101: 0000000000000010     8 OBJECT  LOCAL  DEFAULT    8 static_rodata3
> >>   [...]
> >>
> >>   # bpftool prog
> >>   103: sched_cls  name load_static_dat  tag 37a8b6822fc39a29  gpl
> >>        loaded_at 2019-02-28T02:02:35+0000  uid 0
> >>        xlated 712B  jited 426B  memlock 4096B  map_ids 63,64,65,66
> >>   # bpftool map show id 63
> >>   63: array  name .bss  flags 0x0                      <-- .bss area, rw
> >>       key 4B  value 16B  max_entries 1  memlock 4096B
> >>   # bpftool map show id 64
> >>   64: array  name .data  flags 0x0                     <-- .data area, rw
> >>       key 4B  value 16B  max_entries 1  memlock 4096B
> >>   # bpftool map show id 65
> >>   65: array  name .rodata  flags 0x80                  <-- .rodata area, ro
> >>       key 4B  value 24B  max_entries 1  memlock 4096B
> >>
> >>   # bpftool prog dump xlated id 103
> >>   int load_static_data(struct __sk_buff * skb):
> >>   ; int load_static_data(struct __sk_buff *skb)
> >>      0: (b7) r1 = 0
> >>   ; key = 0;
> >>      1: (63) *(u32 *)(r10 -4) = r1
> >>      2: (bf) r6 = r10
> >>   ; int load_static_data(struct __sk_buff *skb)
> >>      3: (07) r6 += -4
> >>   ; bpf_map_update_elem(&result, &key, &static_bss, 0);
> >>      4: (18) r1 = map[id:66]
> >>      6: (bf) r2 = r6
> >>      7: (18) r3 = map[id:63][0]+0         <-- direct static_bss addr in .bss area
> >>      9: (b7) r4 = 0
> >>     10: (85) call array_map_update_elem#99888
> >>     11: (b7) r1 = 1
> >>   ; key = 1;
> >>     12: (63) *(u32 *)(r10 -4) = r1
> >>   ; bpf_map_update_elem(&result, &key, &static_data, 0);
> >>     13: (18) r1 = map[id:66]
> >>     15: (bf) r2 = r6
> >>     16: (18) r3 = map[id:64][0]+0         <-- direct static_data addr in .data area
> >>     18: (b7) r4 = 0
> >>     19: (85) call array_map_update_elem#99888
> >>     20: (b7) r1 = 2
> >>   ; key = 2;
> >>     21: (63) *(u32 *)(r10 -4) = r1
> >>   ; bpf_map_update_elem(&result, &key, &static_rodata, 0);
> >>     22: (18) r1 = map[id:66]
> >>     24: (bf) r2 = r6
> >>     25: (18) r3 = map[id:65][0]+0         <-- direct static_rodata addr in .rodata area
> >>     27: (b7) r4 = 0
> >>     28: (85) call array_map_update_elem#99888
> >>     29: (b7) r1 = 3
> >>   ; key = 3;
> >>     30: (63) *(u32 *)(r10 -4) = r1
> >>   ; bpf_map_update_elem(&result, &key, &static_bss2, 0);
> >>     31: (18) r7 = map[id:63][0]+8         <--.
> >>     33: (18) r1 = map[id:66]                 |
> >>     35: (bf) r2 = r6                         |
> >>     36: (18) r3 = map[id:63][0]+8         <-- direct static_bss2 addr in .bss area
> >>     38: (b7) r4 = 0
> >>     39: (85) call array_map_update_elem#99888
> >>   [...]
> >>
> >> For now .data/.rodata/.bss maps are not exposed via API to the
> >> user, but this could be done in a subsequent step.
> > 
> > See comment about BPF_MAP_TYPE_HEAP/BLOB map in comments to patch #1,
> > it would probably make more useful API for .data/.rodata/.bss.
> > 
> >>
> >> Based upon recent fix in LLVM, commit c0db6b6bd444 ("[BPF] Don't
> >> fail for static variables").
> >>
> >> Joint work with Joe Stringer.
> >>
> >>   [0] LPC 2018, BPF track, "ELF relocation for static data in BPF",
> >>       http://vger.kernel.org/lpc-bpf2018.html#session-3
> >>
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> Signed-off-by: Joe Stringer <joe@wand.net.nz>
> >> ---
> >>  tools/include/uapi/linux/bpf.h |  10 +-
> >>  tools/lib/bpf/libbpf.c         | 259 +++++++++++++++++++++++++++------
> >>  2 files changed, 226 insertions(+), 43 deletions(-)
> >>
> >> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> >> index 8884072e1a46..04b26f59b413 100644
> >> --- a/tools/include/uapi/linux/bpf.h
> >> +++ b/tools/include/uapi/linux/bpf.h
> >> @@ -287,7 +287,7 @@ enum bpf_attach_type {
> >>
> >>  #define BPF_OBJ_NAME_LEN 16U
> >>
> >> -/* Flags for accessing BPF object */
> >> +/* Flags for accessing BPF object from syscall side. */
> >>  #define BPF_F_RDONLY           (1U << 3)
> >>  #define BPF_F_WRONLY           (1U << 4)
> >>
> >> @@ -297,6 +297,14 @@ enum bpf_attach_type {
> >>  /* Zero-initialize hash function seed. This should only be used for testing. */
> >>  #define BPF_F_ZERO_SEED                (1U << 6)
> >>
> >> +/* Flags for accessing BPF object from program side. */
> >> +#define BPF_F_RDONLY_PROG      (1U << 7)
> >> +#define BPF_F_WRONLY_PROG      (1U << 8)
> >> +#define BPF_F_ACCESS_MASK      (BPF_F_RDONLY |         \
> >> +                                BPF_F_RDONLY_PROG |    \
> >> +                                BPF_F_WRONLY |         \
> >> +                                BPF_F_WRONLY_PROG)
> >> +
> >>  /* flags for BPF_PROG_QUERY */
> >>  #define BPF_F_QUERY_EFFECTIVE  (1U << 0)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 8f8f688f3e9b..969bc3d9f02c 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -139,6 +139,9 @@ struct bpf_program {
> >>                 enum {
> >>                         RELO_LD64,
> >>                         RELO_CALL,
> >> +                       RELO_DATA,
> >> +                       RELO_RODATA,
> >> +                       RELO_BSS,
> > 
> > All three of those are essentially the same relocations, just applied
> > against different ELF sections.
> > I think by having just single RELO_GLOBAL_DATA you can actually
> > simplify a bunch of code below, please see corresponding comments.
> 
> Ok, sounds like a reasonable simplification, will do all well for v3.
> 
> >>                 } type;
> >>                 int insn_idx;
> >>                 union {
> >> @@ -174,7 +177,10 @@ struct bpf_program {
> >>  struct bpf_map {
> >>         int fd;
> >>         char *name;
> >> -       size_t offset;
> >> +       union {
> >> +               __u32 global_type;
> > 
> > This could be an index into common maps array.
> > 
> >> +               size_t offset;
> >> +       };
> >>         int map_ifindex;
> >>         int inner_map_fd;
> >>         struct bpf_map_def def;
> >> @@ -194,6 +200,8 @@ struct bpf_object {
> >>         size_t nr_programs;
> >>         struct bpf_map *maps;
> >>         size_t nr_maps;
> >> +       struct bpf_map *maps_global;
> >> +       size_t nr_maps_global;
> > 
> > Global maps could be stored in maps, along other ones, so that we
> > don't need to keep track of them separately.
> > 
> > Another inconvenience of having a separate array of global maps is
> > that bpf_map__iter won't iterate them. I don't know if that's
> > desirable behavior or not, but it probably would be nice to iterate
> > over global ones as well?
> 
> My thinking was that these maps are not explicitly user specified,
> so libbpf API would expose them through a different interface than
> the one we have today in order to not confuse or break application
> behavior which would otherwise rely on iterating / processing over
> them. Separate API would retain current behavior and definitely
> make this unambiguous to apps with regards to what to expect from
> each of such API call.
> 
> >>         bool loaded;
> >>         bool has_pseudo_calls;
> >> @@ -209,6 +217,9 @@ struct bpf_object {
> >>                 Elf *elf;
> >>                 GElf_Ehdr ehdr;
> >>                 Elf_Data *symbols;
> >> +               Elf_Data *global_data;
> >> +               Elf_Data *global_rodata;
> >> +               Elf_Data *global_bss;
> >>                 size_t strtabidx;
> >>                 struct {
> >>                         GElf_Shdr shdr;
> >> @@ -217,6 +228,9 @@ struct bpf_object {
> >>                 int nr_reloc;
> >>                 int maps_shndx;
> >>                 int text_shndx;
> >> +               int data_shndx;
> >> +               int rodata_shndx;
> >> +               int bss_shndx;
> >>         } efile;
> >>         /*
> >>          * All loaded bpf_object is linked in a list, which is
> >> @@ -457,6 +471,9 @@ static struct bpf_object *bpf_object__new(const char *path,
> >>         obj->efile.obj_buf = obj_buf;
> >>         obj->efile.obj_buf_sz = obj_buf_sz;
> >>         obj->efile.maps_shndx = -1;
> >> +       obj->efile.data_shndx = -1;
> >> +       obj->efile.rodata_shndx = -1;
> >> +       obj->efile.bss_shndx = -1;
> >>
> >>         obj->loaded = false;
> >>
> >> @@ -475,6 +492,9 @@ static void bpf_object__elf_finish(struct bpf_object *obj)
> >>                 obj->efile.elf = NULL;
> >>         }
> >>         obj->efile.symbols = NULL;
> >> +       obj->efile.global_data = NULL;
> >> +       obj->efile.global_rodata = NULL;
> >> +       obj->efile.global_bss = NULL;
> >>
> >>         zfree(&obj->efile.reloc);
> >>         obj->efile.nr_reloc = 0;
> >> @@ -757,6 +777,85 @@ bpf_object__init_maps(struct bpf_object *obj, int flags)
> >>         return 0;
> >>  }
> >>
> >> +static int
> >> +bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map);
> >> +
> >> +static int
> >> +bpf_object__init_global(struct bpf_object *obj, int i, int type,
> >> +                       const char *name, Elf_Data *map_data)
> > 
> > Instead of deducing flags and looking up for map by index, you can
> > just pass struct bpf_map * directly instead of int i and provide
> > flags, instead of type.
> 
> Yep, agree.
> 
> >> +{
> >> +       struct bpf_map *map = &obj->maps_global[i];
> >> +       struct bpf_map_def *def = &map->def;
> >> +       char *cp, errmsg[STRERR_BUFSIZE];
> >> +       int err, slot0 = 0;
> >> +
> >> +       def->type = BPF_MAP_TYPE_ARRAY;
> >> +       def->key_size = sizeof(int);
> >> +       def->value_size = map_data->d_size;
> >> +       def->max_entries = 1;
> >> +       def->map_flags = type == RELO_RODATA ? BPF_F_RDONLY_PROG : 0;
> >> +
> >> +       map->name = strdup(name);
> >> +       map->global_type = type;
> >> +       map->fd = bpf_object__create_map(obj, map);
> >> +       if (map->fd < 0) {
> >> +               err = map->fd;
> >> +               cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
> >> +               pr_warning("failed to create map (name: '%s'): %s\n",
> >> +                          map->name, cp);
> >> +               goto destroy;
> >> +       }
> >> +
> >> +       pr_debug("create map %s: fd=%d\n", map->name, map->fd);
> >> +
> >> +       if (type != RELO_BSS) {
> >> +               err = bpf_map_update_elem(map->fd, &slot0, map_data->d_buf, 0);
> >> +               if (err < 0) {
> >> +                       cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
> >> +                       pr_warning("failed to update map (name: '%s'): %s\n",
> >> +                                  map->name, cp);
> >> +                       goto destroy;
> >> +               }
> >> +
> >> +               pr_debug("updated map %s with elf data: fd=%d\n", map->name,
> >> +                        map->fd);
> >> +       }
> >> +       return 0;
> >> +destroy:
> >> +       for (i = 0; i < obj->nr_maps_global; i++)
> >> +               zclose(obj->maps_global[i].fd);
> >> +       return err;
> >> +}
> >> +
> >> +static int
> >> +bpf_object__init_global_maps(struct bpf_object *obj)
> >> +{
> >> +       int nr_maps_global = (obj->efile.data_shndx >= 0) +
> >> +                            (obj->efile.rodata_shndx >= 0) +
> >> +                            (obj->efile.bss_shndx >= 0), i, err = 0;
> > 
> > This looks like a good candidate for separate static function? It can
> > also be reused below to check if there is any global map present.
> 
> Sounds good.
> 
> >> +
> >> +       obj->maps_global = calloc(nr_maps_global, sizeof(obj->maps_global[0]));
> >> +       if (!obj->maps_global) {
> > 
> > If nr_maps_global is 0, calloc might or might not return NULL, so this
> > check might erroneously return error.
> 
> Good point, just read it up as well from man page, will fix.
> 
> >> +               pr_warning("alloc maps for object failed\n");
> >> +               return -ENOMEM;
> >> +       }
> >> +
> >> +       obj->nr_maps_global = nr_maps_global;
> >> +       for (i = 0; i < obj->nr_maps_global; i++)
> >> +               obj->maps[i].fd = -1;
> >> +       i = 0;
> >> +       if (obj->efile.bss_shndx >= 0)
> >> +               err = bpf_object__init_global(obj, i++, RELO_BSS, ".bss",
> >> +                                             obj->efile.global_bss);
> >> +       if (obj->efile.data_shndx >= 0 && !err)
> >> +               err = bpf_object__init_global(obj, i++, RELO_DATA, ".data",
> >> +                                             obj->efile.global_data);
> >> +       if (obj->efile.rodata_shndx >= 0 && !err)
> >> +               err = bpf_object__init_global(obj, i++, RELO_RODATA, ".rodata",
> >> +                                             obj->efile.global_rodata);
> > 
> > Here we know exactly what type of map we are creating, so we can just
> > directly pass all the required structs/flags/data.
> > 
> > Also, to speed up and simplify relocation processing below, I think
> > it's better to store map indexes for each of available .bss, .data and
> > .rodata maps, eliminating another need for having three different
> > types of data relocations.
> 
> Yep, I'll clean this up.
> 
> >> +       return err;
> >> +}
> >> +
> >>  static bool section_have_execinstr(struct bpf_object *obj, int idx)
> >>  {
> >>         Elf_Scn *scn;
> >> @@ -865,6 +964,12 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
> >>                                         pr_warning("failed to alloc program %s (%s): %s",
> >>                                                    name, obj->path, cp);
> >>                                 }
> >> +                       } else if (strcmp(name, ".data") == 0) {
> >> +                               obj->efile.global_data = data;
> >> +                               obj->efile.data_shndx = idx;
> >> +                       } else if (strcmp(name, ".rodata") == 0) {
> >> +                               obj->efile.global_rodata = data;
> >> +                               obj->efile.rodata_shndx = idx;
> >>                         }
> > 
> > Previously if we encountered unknown PROGBITS section, we'd emit debug
> > message about skipping section, should we add that message here?
> 
> Sounds reasonable, I'll add a similar 'skip section' debug output there.
> 
> >>                 } else if (sh.sh_type == SHT_REL) {
> >>                         void *reloc = obj->efile.reloc;
> >> @@ -892,6 +997,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
> >>                                 obj->efile.reloc[n].shdr = sh;
> >>                                 obj->efile.reloc[n].data = data;
> >>                         }
> >> +               } else if (sh.sh_type == SHT_NOBITS && strcmp(name, ".bss") == 0) {
> >> +                       obj->efile.global_bss = data;
> >> +                       obj->efile.bss_shndx = idx;
> >>                 } else {
> >>                         pr_debug("skip section(%d) %s\n", idx, name);
> >>                 }
> >> @@ -923,6 +1031,14 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
> >>                 if (err)
> >>                         goto out;
> >>         }
> >> +       if (obj->efile.data_shndx >= 0 ||
> >> +           obj->efile.rodata_shndx >= 0 ||
> >> +           obj->efile.bss_shndx >= 0) {
> >> +               err = bpf_object__init_global_maps(obj);
> >> +               if (err)
> >> +                       goto out;
> >> +       }
> >> +
> >>         err = bpf_object__init_prog_names(obj);
> >>  out:
> >>         return err;
> >> @@ -961,6 +1077,11 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
> >>         Elf_Data *symbols = obj->efile.symbols;
> >>         int text_shndx = obj->efile.text_shndx;
> >>         int maps_shndx = obj->efile.maps_shndx;
> >> +       int data_shndx = obj->efile.data_shndx;
> >> +       int rodata_shndx = obj->efile.rodata_shndx;
> >> +       int bss_shndx = obj->efile.bss_shndx;
> >> +       struct bpf_map *maps_global = obj->maps_global;
> >> +       size_t nr_maps_global = obj->nr_maps_global;
> >>         struct bpf_map *maps = obj->maps;
> >>         size_t nr_maps = obj->nr_maps;
> >>         int i, nrels;
> >> @@ -999,8 +1120,10 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
> >>                          (long long) (rel.r_info >> 32),
> >>                          (long long) sym.st_value, sym.st_name);
> >>
> >> -               if (sym.st_shndx != maps_shndx && sym.st_shndx != text_shndx) {
> >> -                       pr_warning("Program '%s' contains non-map related relo data pointing to section %u\n",
> >> +               if (sym.st_shndx != maps_shndx && sym.st_shndx != text_shndx &&
> >> +                   sym.st_shndx != data_shndx && sym.st_shndx != rodata_shndx &&
> >> +                   sym.st_shndx != bss_shndx) {
> >> +                       pr_warning("Program '%s' contains unrecognized relo data pointing to section %u\n",
> >>                                    prog->section_name, sym.st_shndx);
> >>                         return -LIBBPF_ERRNO__RELOC;
> >>                 }
> >> @@ -1045,6 +1168,30 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
> >>                         prog->reloc_desc[i].type = RELO_LD64;
> >>                         prog->reloc_desc[i].insn_idx = insn_idx;
> >>                         prog->reloc_desc[i].map_idx = map_idx;
> >> +               } else if (sym.st_shndx == data_shndx ||
> >> +                          sym.st_shndx == rodata_shndx ||
> >> +                          sym.st_shndx == bss_shndx) {
> >> +                       int type = (sym.st_shndx == data_shndx)   ? RELO_DATA :
> >> +                                  (sym.st_shndx == rodata_shndx) ? RELO_RODATA :
> >> +                                                                   RELO_BSS;
> >> +
> >> +                       for (map_idx = 0; map_idx < nr_maps_global; map_idx++) {
> >> +                               if (maps_global[map_idx].global_type == type) {
> >> +                                       pr_debug("relocation: find map %zd (%s) for insn %u\n",
> >> +                                                map_idx, maps_global[map_idx].name, insn_idx);
> >> +                                       break;
> >> +                               }
> >> +                       }
> >> +
> >> +                       if (map_idx >= nr_maps_global) {
> >> +                               pr_warning("bpf relocation: map_idx %d large than %d\n",
> >> +                                          (int)map_idx, (int)nr_maps_global - 1);
> >> +                               return -LIBBPF_ERRNO__RELOC;
> >> +                       }
> > 
> > We don't need to handle all of this if we just remember global map
> > indicies during creation, instead of calculating type, we can just
> > pick correct index (and check it exists). And type can be just generic
> > RELO_DATA.
> > 
> >> +
> >> +                       prog->reloc_desc[i].type = type;
> >> +                       prog->reloc_desc[i].insn_idx = insn_idx;
> >> +                       prog->reloc_desc[i].map_idx = map_idx;
> >>                 }
> >>         }
> >>         return 0;
> >> @@ -1176,15 +1323,58 @@ bpf_object__probe_caps(struct bpf_object *obj)
> >>  }
> >>
> >>  static int
> >> -bpf_object__create_maps(struct bpf_object *obj)
> >> +bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map)
> >>  {
> >>         struct bpf_create_map_attr create_attr = {};
> >> +       struct bpf_map_def *def = &map->def;
> >> +       char *cp, errmsg[STRERR_BUFSIZE];
> >> +       int fd;
> >> +
> >> +       if (obj->caps.name)
> >> +               create_attr.name = map->name;
> >> +       create_attr.map_ifindex = map->map_ifindex;
> >> +       create_attr.map_type = def->type;
> >> +       create_attr.map_flags = def->map_flags;
> >> +       create_attr.key_size = def->key_size;
> >> +       create_attr.value_size = def->value_size;
> >> +       create_attr.max_entries = def->max_entries;
> >> +       create_attr.btf_fd = 0;
> >> +       create_attr.btf_key_type_id = 0;
> >> +       create_attr.btf_value_type_id = 0;
> >> +       if (bpf_map_type__is_map_in_map(def->type) &&
> >> +           map->inner_map_fd >= 0)
> >> +               create_attr.inner_map_fd = map->inner_map_fd;
> >> +       if (obj->btf && !bpf_map_find_btf_info(map, obj->btf)) {
> >> +               create_attr.btf_fd = btf__fd(obj->btf);
> >> +               create_attr.btf_key_type_id = map->btf_key_type_id;
> >> +               create_attr.btf_value_type_id = map->btf_value_type_id;
> >> +       }
> >> +
> >> +       fd = bpf_create_map_xattr(&create_attr);
> >> +       if (fd < 0 && create_attr.btf_key_type_id) {
> >> +               cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
> >> +               pr_warning("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
> >> +                          map->name, cp, errno);
> >> +
> >> +               create_attr.btf_fd = 0;
> >> +               create_attr.btf_key_type_id = 0;
> >> +               create_attr.btf_value_type_id = 0;
> >> +               map->btf_key_type_id = 0;
> >> +               map->btf_value_type_id = 0;
> >> +               fd = bpf_create_map_xattr(&create_attr);
> >> +       }
> >> +
> >> +       return fd;
> >> +}
> >> +
> >> +static int
> >> +bpf_object__create_maps(struct bpf_object *obj)
> >> +{
> >>         unsigned int i;
> >>         int err;
> >>
> >>         for (i = 0; i < obj->nr_maps; i++) {
> >>                 struct bpf_map *map = &obj->maps[i];
> >> -               struct bpf_map_def *def = &map->def;
> >>                 char *cp, errmsg[STRERR_BUFSIZE];
> >>                 int *pfd = &map->fd;
> >>
> >> @@ -1193,41 +1383,7 @@ bpf_object__create_maps(struct bpf_object *obj)
> >>                                  map->name, map->fd);
> >>                         continue;
> >>                 }
> >> -
> >> -               if (obj->caps.name)
> >> -                       create_attr.name = map->name;
> >> -               create_attr.map_ifindex = map->map_ifindex;
> >> -               create_attr.map_type = def->type;
> >> -               create_attr.map_flags = def->map_flags;
> >> -               create_attr.key_size = def->key_size;
> >> -               create_attr.value_size = def->value_size;
> >> -               create_attr.max_entries = def->max_entries;
> >> -               create_attr.btf_fd = 0;
> >> -               create_attr.btf_key_type_id = 0;
> >> -               create_attr.btf_value_type_id = 0;
> >> -               if (bpf_map_type__is_map_in_map(def->type) &&
> >> -                   map->inner_map_fd >= 0)
> >> -                       create_attr.inner_map_fd = map->inner_map_fd;
> >> -
> >> -               if (obj->btf && !bpf_map_find_btf_info(map, obj->btf)) {
> >> -                       create_attr.btf_fd = btf__fd(obj->btf);
> >> -                       create_attr.btf_key_type_id = map->btf_key_type_id;
> >> -                       create_attr.btf_value_type_id = map->btf_value_type_id;
> >> -               }
> >> -
> >> -               *pfd = bpf_create_map_xattr(&create_attr);
> >> -               if (*pfd < 0 && create_attr.btf_key_type_id) {
> >> -                       cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
> >> -                       pr_warning("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
> >> -                                  map->name, cp, errno);
> >> -                       create_attr.btf_fd = 0;
> >> -                       create_attr.btf_key_type_id = 0;
> >> -                       create_attr.btf_value_type_id = 0;
> >> -                       map->btf_key_type_id = 0;
> >> -                       map->btf_value_type_id = 0;
> >> -                       *pfd = bpf_create_map_xattr(&create_attr);
> >> -               }
> >> -
> >> +               *pfd = bpf_object__create_map(obj, map);
> >>                 if (*pfd < 0) {
> >>                         size_t j;
> >>
> >> @@ -1412,6 +1568,24 @@ bpf_program__relocate(struct bpf_program *prog, struct bpf_object *obj)
> >>                                                       &prog->reloc_desc[i]);
> >>                         if (err)
> >>                                 return err;
> >> +               } else if (prog->reloc_desc[i].type == RELO_DATA ||
> >> +                          prog->reloc_desc[i].type == RELO_RODATA ||
> >> +                          prog->reloc_desc[i].type == RELO_BSS) {
> >> +                       struct bpf_insn *insns = prog->insns;
> >> +                       int insn_idx, map_idx, data_off;
> >> +
> >> +                       insn_idx = prog->reloc_desc[i].insn_idx;
> >> +                       map_idx  = prog->reloc_desc[i].map_idx;
> >> +                       data_off = insns[insn_idx].imm;
> >> +
> >> +                       if (insn_idx + 1 >= (int)prog->insns_cnt) {
> >> +                               pr_warning("relocation out of range: '%s'\n",
> >> +                                          prog->section_name);
> >> +                               return -LIBBPF_ERRNO__RELOC;
> >> +                       }
> >> +                       insns[insn_idx].src_reg = BPF_PSEUDO_MAP_VALUE;
> >> +                       insns[insn_idx].imm = obj->maps_global[map_idx].fd;
> >> +                       insns[insn_idx + 1].imm = data_off;
> >>                 }
> >>         }
> >>
> >> @@ -1717,6 +1891,7 @@ __bpf_object__open(const char *path, void *obj_buf, size_t obj_buf_sz,
> >>
> >>         CHECK_ERR(bpf_object__elf_init(obj), err, out);
> >>         CHECK_ERR(bpf_object__check_endianness(obj), err, out);
> >> +       CHECK_ERR(bpf_object__probe_caps(obj), err, out);
> >>         CHECK_ERR(bpf_object__elf_collect(obj, flags), err, out);
> >>         CHECK_ERR(bpf_object__collect_reloc(obj), err, out);
> >>         CHECK_ERR(bpf_object__validate(obj, needs_kver), err, out);
> >> @@ -1789,7 +1964,8 @@ int bpf_object__unload(struct bpf_object *obj)
> >>
> >>         for (i = 0; i < obj->nr_maps; i++)
> >>                 zclose(obj->maps[i].fd);
> >> -
> >> +       for (i = 0; i < obj->nr_maps_global; i++)
> >> +               zclose(obj->maps_global[i].fd);
> >>         for (i = 0; i < obj->nr_programs; i++)
> >>                 bpf_program__unload(&obj->programs[i]);
> >>
> >> @@ -1810,7 +1986,6 @@ int bpf_object__load(struct bpf_object *obj)
> >>
> >>         obj->loaded = true;
> >>
> >> -       CHECK_ERR(bpf_object__probe_caps(obj), err, out);
> >>         CHECK_ERR(bpf_object__create_maps(obj), err, out);
> >>         CHECK_ERR(bpf_object__relocate(obj), err, out);
> >>         CHECK_ERR(bpf_object__load_progs(obj), err, out);
> >> --
> >> 2.17.1
> >>
> > 
> > I'm sorry if I seem a bit too obsessed with those three new relocation
> > types. I just believe that having one generic and storing global maps
> > along with other maps is cleaner and more uniform.
> 
> No worries, thanks for all your feedback and review!
> 
> Thanks,
> Daniel
