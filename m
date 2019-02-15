Return-Path: <SRS0=ZyRU=QW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4672FC43381
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 05:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074F62146E
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 05:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaAmyO62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfBOFi6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:38:58 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38727 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfBOFi6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Feb 2019 00:38:58 -0500
Received: by mail-it1-f195.google.com with SMTP id l66so10552114itg.3;
        Thu, 14 Feb 2019 21:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/6y7eiz3XahsI7nsoJyvSHyW7L+aKVtNCip6KXdHseg=;
        b=BaAmyO62e+axNfOpzwa86pth3+nRdzA+LDth8GtYLjCHEbqSuEeuJ2e4SbzMl6qYLP
         ccHerM1IVnIexPo8GeklYumK+LdqNoqTSHqM/2rtVPsr42jB6M1//mo3PMusdqcIj5cT
         Pk6SbLkJNurFo7Swv1uCeFPRaoDwD1X9ZIX6h13iqYKSNy0wbP6R38G6ty03LCXO/IQG
         2ekTx3popS9U3xvk27PAB0Lolk6BXROAzMa0PzCJdflTWRur8LG9uNJetH2amAzO1Av9
         0smlI9vzfN/qx5FWBOLvSa8c2T2w7kt9edDTfJGRniQnjeYmwoxCQpjMIF/HmdwmpLrB
         42/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6y7eiz3XahsI7nsoJyvSHyW7L+aKVtNCip6KXdHseg=;
        b=oR8+bc1ROwykpGk22hS2Xxqaib1IIFZ9p0+lEwXBfhAoCEY5Iaaig9iw9sU7uQTM+g
         n/gcxRbxYKjEowO2Lul2PXPEXn4d7mKCwcgs/ga5aMQhvDEuWyvUdJ7tQW7Iloocied7
         irXtJ+g6eA9NLbhYw6IF7KX6LQ6gPpeMyTkh5u6Nsdzw4hc2e4hWH+BfMgaGEuVcLxzm
         mXmQByCnp0ZaHx95VugrhQJjJZjXzFnIL4fdLgLd0DWLa9ii+WeHrbz1AggAqRJiyYXg
         05hz8Ni9qwA4bDXzxC8/mWVcSObKiakpa8illWQzq6C4myQBys4/4bTS0pjy7aHsz283
         59IQ==
X-Gm-Message-State: AHQUAuYIeAAdJUIdU94aND424zX5JSaUpErJrrFpHkkpi3joYfQeYOgC
        cWW8EkHczk8ukI4iJs9zVl2CB7T2Xo5BscDf+GU1SA==
X-Google-Smtp-Source: AHgI3IaWDaaXIEKZG6LKcxjfZNSTB6OLghroYmm9Zoxmda6Be2WDBcU2WtUx4bGSoNzSHg03fhQwsaW9aVDaONbUAoc=
X-Received: by 2002:a5d:8784:: with SMTP id f4mr42909ion.89.1550209136929;
 Thu, 14 Feb 2019 21:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20190212004729.535-1-joe@wand.net.nz> <20190212004729.535-3-joe@wand.net.nz>
In-Reply-To: <20190212004729.535-3-joe@wand.net.nz>
From:   Y Song <ys114321@gmail.com>
Date:   Thu, 14 Feb 2019 21:38:20 -0800
Message-ID: <CAH3MdRVU5ayEm6eb9Fz53Q5gjA60vadyJ+0_meCkWBo+t+XXYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] libbpf: Support 32-bit static data loads
To:     Joe Stringer <joe@wand.net.nz>
Cc:     bpf@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 11, 2019 at 4:48 PM Joe Stringer <joe@wand.net.nz> wrote:
>
> Support loads of static 32-bit data when BPF writers make use of
> convenience macros for accessing static global data variables. A later
> patch in this series will demonstrate its usage in a selftest.
>
> As of LLVM-7, this technique only works with 32-bit data, as LLVM will
> complain if this technique is attempted with data of other sizes:
>
>     LLVM ERROR: Unsupported relocation: try to compile with -O2 or above,
>     or check your static variable usage

A little bit clarification from compiler side.
The above compiler error is to prevent people use static variables since current
kernel/libbpf does not handle this. The compiler only warns if .bss or
.data section
has more than one definitions. The first definition always has section offset 0
and the compiler did not warn.

The restriction is a little strange. To only work with 32-bit data is
not a right
statement. The following are some examples.

The following static variable definitions will succeed:
static int a; /* one in .bss */
static long b = 2;  /* one in .data */

The following definitions will fail as both in .bss.
static int a;
static int b;

The following definitions will fail as both in .data:
static char a = 2;
static int b = 3;

Using global variables can prevent compiler errors.
maps are defined as globals and the compiler does not
check whether a particular global variable is defining a map or not.

If you just use static variable like below
static int a = 2;
without potential assignment to a, the compiler will replace variable
a with 2 at compile time.
An alternative is to define like below
static volatile int a = 2;
You can get a "load" for variable "a" in the bpf load even if there is
no assignment to a.

Maybe now is the time to remove the compiler assertions as
libbpf/kernel starts to
handle static variables?

>
> Based on the proof of concept by Daniel Borkmann (presented at LPC 2018).
>
> Signed-off-by: Joe Stringer <joe@wand.net.nz>
> ---
>  tools/lib/bpf/libbpf.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1ec28d5154dc..da35d5559b22 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -140,11 +140,13 @@ struct bpf_program {
>                 enum {
>                         RELO_LD64,
>                         RELO_CALL,
> +                       RELO_DATA,
>                 } type;
>                 int insn_idx;
>                 union {
>                         int map_idx;
>                         int text_off;
> +                       uint32_t data;
>                 };
>         } *reloc_desc;
>         int nr_reloc;
> @@ -210,6 +212,7 @@ struct bpf_object {
>                 Elf *elf;
>                 GElf_Ehdr ehdr;
>                 Elf_Data *symbols;
> +               Elf_Data *global_data;
>                 size_t strtabidx;
>                 struct {
>                         GElf_Shdr shdr;
> @@ -218,6 +221,7 @@ struct bpf_object {
>                 int nr_reloc;
>                 int maps_shndx;
>                 int text_shndx;
> +               int data_shndx;
>         } efile;
>         /*
>          * All loaded bpf_object is linked in a list, which is
> @@ -476,6 +480,7 @@ static void bpf_object__elf_finish(struct bpf_object *obj)
>                 obj->efile.elf = NULL;
>         }
>         obj->efile.symbols = NULL;
> +       obj->efile.global_data = NULL;
>
>         zfree(&obj->efile.reloc);
>         obj->efile.nr_reloc = 0;
> @@ -866,6 +871,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
>                                         pr_warning("failed to alloc program %s (%s): %s",
>                                                    name, obj->path, cp);
>                                 }
> +                       } else if (strcmp(name, ".data") == 0) {
> +                               obj->efile.global_data = data;
> +                               obj->efile.data_shndx = idx;
>                         }
>                 } else if (sh.sh_type == SHT_REL) {
>                         void *reloc = obj->efile.reloc;
> @@ -962,6 +970,7 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
>         Elf_Data *symbols = obj->efile.symbols;
>         int text_shndx = obj->efile.text_shndx;
>         int maps_shndx = obj->efile.maps_shndx;
> +       int data_shndx = obj->efile.data_shndx;
>         struct bpf_map *maps = obj->maps;
>         size_t nr_maps = obj->nr_maps;
>         int i, nrels;
> @@ -1000,8 +1009,9 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
>                          (long long) (rel.r_info >> 32),
>                          (long long) sym.st_value, sym.st_name);
>
> -               if (sym.st_shndx != maps_shndx && sym.st_shndx != text_shndx) {
> -                       pr_warning("Program '%s' contains non-map related relo data pointing to section %u\n",
> +               if (sym.st_shndx != maps_shndx && sym.st_shndx != text_shndx &&
> +                   sym.st_shndx != data_shndx) {
> +                       pr_warning("Program '%s' contains unrecognized relo data pointing to section %u\n",
>                                    prog->section_name, sym.st_shndx);
>                         return -LIBBPF_ERRNO__RELOC;
>                 }
> @@ -1046,6 +1056,20 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
>                         prog->reloc_desc[i].type = RELO_LD64;
>                         prog->reloc_desc[i].insn_idx = insn_idx;
>                         prog->reloc_desc[i].map_idx = map_idx;
> +               } else if (sym.st_shndx == data_shndx) {
> +                       Elf_Data *global_data = obj->efile.global_data;
> +                       uint32_t *static_data;
> +
> +                       if (sym.st_value + sizeof(uint32_t) > (int)global_data->d_size) {
> +                               pr_warning("bpf relocation: static data load beyond data size %lu\n",
> +                                          global_data->d_size);
> +                               return -LIBBPF_ERRNO__RELOC;
> +                       }
> +
> +                       static_data = global_data->d_buf + sym.st_value;
> +                       prog->reloc_desc[i].type = RELO_DATA;
> +                       prog->reloc_desc[i].insn_idx = insn_idx;
> +                       prog->reloc_desc[i].data = *static_data;
>                 }
>         }
>         return 0;
> @@ -1399,6 +1423,12 @@ bpf_program__relocate(struct bpf_program *prog, struct bpf_object *obj)
>                                                       &prog->reloc_desc[i]);
>                         if (err)
>                                 return err;
> +               } else if (prog->reloc_desc[i].type == RELO_DATA) {
> +                       struct bpf_insn *insns = prog->insns;
> +                       int insn_idx;
> +
> +                       insn_idx = prog->reloc_desc[i].insn_idx;
> +                       insns[insn_idx].imm = prog->reloc_desc[i].data;
>                 }
>         }
>
> --
> 2.19.1
>
